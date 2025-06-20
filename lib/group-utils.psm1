function Get-DistributionList {
    [CmdletBinding()]
    [OutputType([psobject])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $Name,
        [String] $Description,
        [psobject[]] $groups
    )
    $distributionList = $groups | Where-Object { $_.DisplayName -eq $Name }
    if ($null -eq $distributionList) {
        Write-Host "M365 group '$Name' doesn't exist, creating..."

        $distributionList = New-MgGroup -DisplayName $Name -MailEnabled:$true -MailNickname $Name -Description $Description -GroupTypes 'Unified' -SecurityEnabled:$true -Visibility 'Private'
        if ($null -eq $distributionList) {
            $returnObj.AddErrorMessage("FAILED to find or create: $($Name) M365 group in Entra")
            throw "FAILED to find or create: $($Name) M365 group in Entra"
        }
    } else {
        Write-Host "M365 group '$Name' already exists."
    }
    return $distributionList
}

function Get-AwsAccountGroupName {
    [CmdletBinding()]
    [OutputType([psobject])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $workloadShortName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $environment,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $role,
        [bool] $isUkhsaGroupFormat = $true
    )

    $workloadShortName = $workloadShortName.substring(0, 1).ToUpper() + $workloadShortName.substring(1).ToLower()
    
    if ($isUkhsaGroupFormat) {
        return "Grp.Aws.Console.$($workloadShortName).$($environment).$($role)"
    } else {
        return "WlAws$($workloadShortName)$($environment)$($role)"
    }
}

function Add-RoleGroups {
    [CmdletBinding()]
    [OutputType([psobject])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $roles,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String[]] $ownerSPNs,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $workloadShortName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $environment,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [psobject] $enterpriseAppConfig,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $tenantId,
        [bool] $isUkhsaGroupFormat = $true,
        [psobject[]] $groups
    )
    $owners1 = [string[]]($ownerSPNs.split(',') | ForEach-Object { "https://graph.microsoft.com/v1.0/servicePrincipals/$($_)" })
    $owners2 = @("https://graph.microsoft.com/v1.0/servicePrincipals/$ownerSPN")
    
    Write-Host $owners1
    Write-Host $owners2
}

function Get-GroupMailNickname {
    [CmdletBinding()]
    [OutputType([psobject])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $GroupName,
        [bool] $isUkhsaGroupFormat = $true
    )
    $maxGroupMailNicknameLength = 64 # as per https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.groups/new-mggroup

    # If the group name is less than the max, then just use that
    if ($GroupName.Length -le $maxGroupMailNicknameLength) {
        return $GroupName
    }

    # Otherwise use a subset of that string.
    # Trying to convert it to a unique identifier, representing the workload, account name and permission set
    if ($isUkhsaGroupFormat) {
        # Split the string by dots: "Grp", "Aws", "Console", workload name, acount name, permission set
        $splittedGroupName = $GroupName.Split('.')
        # get only the bits we're interested in
        $mailNickname = $splittedGroupName[3..($splittedGroupName.Count - 1)] -join ""
    } else {
        # Split the string by capital letters: "Wl", "Aws", workload name, acount name, finally several items for the permission set
        $splittedGroupName = [regex]::Split($GroupName, "(?=[A-Z])")
        # get only the bits we're interested in
        $mailNickname = $splittedGroupName[3..($splittedGroupName.Count - 1)] -join ""
    }

    # And replace some words for shorter representations
    $mailNickname = $mailNickname.replace('Account','Acct').replace('Deployment','Dpl').replace('Advanced','Adv').replace('Analyst','Anl').replace('Application','App').replace('Developer','Dev').replace('Support','Spt').replace('Data','Dt').replace('Database','Db').replace('Administrator','Adm').replace('Engineer','Eng').replace('Operations','Ops').replace('Quality','Qa').replace('Reader','Rd').replace('Scientist','Sc').replace('Uploader','Upd').replace('Migration','Mg').replace('Platform','Pt').replace('Author','Auth').replace('Viewer','Vw').replace('QuickSight','Qs')

    return $mailNickname
}

function Add-GroupToEA {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [psobject] $entraGroup,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [psobject] $enterpriseAppConfig
    )

    $params = @{
        PrincipalId = "$($entraGroup.Id)"
        ResourceId  = "$($enterpriseAppConfig.ObjectId)"
        AppRoleId   = "$($enterpriseAppConfig.UserRoleId)"
    }

    Write-Host "PrincipalId: $($params.PrincipalId)"
    Write-Host "ResourceId: $($params.ResourceId)"
    Write-Host "AppRoleId: $($params.AppRoleId)"
    Write-Host "Entra Id: $($entraGroup.Id)"
    Write-Host "Entra DisplayName: $($entraGroup.DisplayName)"


    Write-Host "Adding Entra group: $($entraGroup.DisplayName) to AWS Enterprise Application: $($enterpriseAppConfig.ObjectId)"
    $null = New-MgGroupAppRoleAssignment -GroupId $entraGroup.Id -BodyParameter $params
    Write-Host "Successfully added Entra group: $($entraGroup.DisplayName) to AWS Enterprise Application: $($enterpriseAppConfig.ObjectId)"
}