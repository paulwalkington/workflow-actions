

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

environment=$1
name=$2
emailAddress=$3
workloadShortName=$4
opsDlMail=$5
securityDlMail=$6
roles=$7
dnsSubDomains=$8
sesSubDomains=$9
securityClass=$10


# environment="some_environment"
# name="some_name"
# emailAddress="some_email_address"
# workloadShortName="some_WORKload_short_name1"
# opsDlMail="some_ops_dl_mail"
# securityDlMail="some_security_dl_mail"
# roles="Administrator,ReadOnly,ApplicationUser"
# dnsSubDomains="foo,bar"
# sesSubDomains="foo,bar"
# securityClass="Non-Live"

vpcRequired="Yes"
# these come from the "get-vpc-cidr" step in the pipeline
vpcDetailsTransitSubnetNewBits=2 
vpcDetailsTransitSubnetNetNum=0
cidr="172.25.128.0/17"



workloadShortNameLowerCase=$(echo "$workloadShortName" | tr '[:upper:]' '[:lower:]')
opsDlMailLowerCase=$(echo "$opsDlMail" | tr '[:upper:]' '[:lower:]')
securityDlMailLowerCase=$(echo "$securityDlMail" | tr '[:upper:]' '[:lower:]')




# cat <<EOF > etc/env_eu-west-2_$environment.tfvars
cat > "etc/env_eu-west-2_$environment.tfvars"<< EOF
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


# add avm_sso_associations to the tfvars file
if([ -n "$roles" ] )
then
    IFS=',' read -ra rolesSeperated <<< "$roles"

    avmSsoAssociations=()

    for role in "${rolesSeperated[@]}"
    do
        awsAccountGroupName=$(getAwsAccountGroupName "aai" "Development" $role true  )
        avmSsoAssociation=("\"$awsAccountGroupName\" = [ \"$role\" ]")
        avmSsoAssociations+=("$avmSsoAssociation")
    done

    {
        echo " ";
        echo "avm_sso_associations = {";
     } >> etc/env_eu-west-2_$environment.tfvars
     
    for avmSsoAssociation in "${avmSsoAssociations[@]}"
    do
        echo "    $avmSsoAssociation" >> etc/env_eu-west-2_$environment.tfvars
    done

    echo "}" >>  etc/env_eu-west-2_$environment.tfvars
fi

# add avm_aws_account_ses_subdomains to the tfvars file

if([ -n "$sesSubDomains" ] )
then

    IFS=',' read -ra sesSubDomainsSeperated <<< "$sesSubDomains"

    {
        echo " ";
        echo "avm_aws_account_ses_subdomains = {";
        echo "    \"test-and-trace.nhs.uk\" = [";
    } >> etc/env_eu-west-2_$environment.tfvars

    for sesSubDomain in "${sesSubDomainsSeperated[@]}"
    do
        sesSubDomainLowerCase=$(echo "$sesSubDomain" | tr '[:upper:]' '[:lower:]')
        echo "        \"$sesSubDomainLowerCase\"," >> etc/env_eu-west-2_$environment.tfvars
    done



    {
        echo "    ]";
        echo "}";
    } >>  etc/env_eu-west-2_$environment.tfvars
fi

# add avm_aws_account_subdomains to the tfvars file

if([ -n "$dnsSubDomains" ] )
then

    IFS=',' read -ra dnsSubDomainsSeperated <<< "$dnsSubDomains"

    {
        echo " ";
        echo "avm_aws_account_subdomains = {";
        echo "    \"test-and-trace.nhs.uk\" = [";
     } >> etc/env_eu-west-2_$environment.tfvars

    for dnsSubDomain in "${dnsSubDomainsSeperated[@]}"
    do
        dnsSubDomainLowerCase=$(echo "$dnsSubDomain" | tr '[:upper:]' '[:lower:]')
        echo "        \"$dnsSubDomainLowerCase\"," >> etc/env_eu-west-2_$environment.tfvars
    done



    {
        echo "    ]";
        echo "}";
     } >>  etc/env_eu-west-2_$environment.tfvars
fi

# add avm_vpcs to the tfvars file

if [[ "$vpcRequired" == "Yes" ]]
then
{ 
    echo " ";
    echo " ";
    echo "avm_vpc = {";
    echo "    main = {";
    echo "        subnets_transit = \"$vpcDetailsTransitSubnetNewBits,$vpcDetailsTransitSubnetNetNum\"";
    echo "        vpc_cidr        = \"$cidr\"";
    echo "    }";
    echo "}"
} >> etc/env_eu-west-2_$environment.tfvars
fi

# add others to the tfvars file


if [[ "$securityClass" == "Non-Live" ]]
then
{ 
    echo "" ; 
    echo "avm_auto_shutdown_enabled       = true"; 
    echo "config_kms_key_deletion_enabled = false"; 
} >> etc/env_eu-west-2_$environment.tfvars
fi