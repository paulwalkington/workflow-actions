function getAwsAccountGroupName () {
    workloadShortName=$1
    environment=$2
    role=$3
    isUkhsaGroupFormat=$4

    workloadShortNameLength=${#workloadShortName}

    workloadShortNameUpper=$(echo ${workloadShortName:0:1} | tr '[:lower:]' '[:upper:]')
    workloadShortNameLower=$(echo ${workloadShortName:1:$workloadShortNameLength} | tr '[:upper:]' '[:lower:]')
    workloadShortNameFormatted=$workloadShortNameUpper$workloadShortNameLower


    if $isUkhsaGroupFormat && [ -n "$isUkhsaGroupFormat" ]
    then
        echo "Grp.Aws.Console.$workloadShortNameFormatted.$environment.$role"
    else 
        echo "WlAws$workloadShortNameFormatted$environment$role"
    fi


}

 
mystr=$(getAwsAccountGroupName "aai" "Development" "Administrator" true  )
echo "$mystr"



environment="some_environment"
name="some_name"
emailAddress="some_email_address"
workloadShortName="some_WORKload_short_name1"
opsDlMail="some_ops_dl_mail"
securityDlMail="some_security_dl_mail"

workloadShortNameLowerCase=$(echo "$workloadShortName" | tr '[:upper:]' '[:lower:]')
opsDlMailLowerCase=$(echo "$opsDlMail" | tr '[:upper:]' '[:lower:]')
securityDlMailLowerCase=$(echo "$securityDlMail" | tr '[:upper:]' '[:lower:]')


cat <<EOF > etc/env_eu-west-2_$environment.tfvars
environment           = "$environment"
avm_aws_account_name  = "$name"
avm_aws_account_email = "$emailAddress"
avm_aws_account_alias = "halo-pr-$environment"
avm_org_ou_name       = "$workloadShortNameLowerCase"

avm_alternate_account_contacts = {
    operations = {
        email_address = "$opsDlMailLowerCase"
        name          = "AWS Alternate Contacts - $workloadShortNameLowerCase - Operations"
        phone_number  = "+442083277777"
        title         = "."
    }
    security = {
        email_address = "$securityDlMailLowerCase"
        name          = "AWS Alternate Contacts - $workloadShortNameLowerCase - Security"
        phone_number  = "+442083277777"
        title         = "."
    }
}
EOF



# function Get-AwsAccountGroupName {
#     [CmdletBinding()]
#     [OutputType([psobject])]
#     param (
#         [Parameter(Mandatory = $true)]
#         [ValidateNotNullOrEmpty()]
#         [String] $workloadShortName,
#         [Parameter(Mandatory = $true)]
#         [ValidateNotNullOrEmpty()]
#         [String] $environment,
#         [Parameter(Mandatory = $true)]
#         [ValidateNotNullOrEmpty()]
#         [String] $role,
#         [bool] $isUkhsaGroupFormat = $true
#     )

#     $workloadShortName = $workloadShortName.substring(0, 1).ToUpper() + $workloadShortName.substring(1).ToLower()

#     if ($isUkhsaGroupFormat) {
#         return "Grp.Aws.Console.$($workloadShortName).$($environment).$($role)"
#     } else {
#         return "WlAws$($workloadShortName)$($environment)$($role)"
#     }
# }