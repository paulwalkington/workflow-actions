#!/usr/bin/env bash

function getAwsAccountGroupName () {
    workloadShortName=$1
    environment=$2
    role=$3
    isUkhsaGroupFormat=$4

    workloadShortNameLength=${#workloadShortName}

    workloadShortNameUpper=$(echo "${workloadShortName:0:1}" | tr '[:lower:]' '[:upper:]')
    workloadShortNameLower=$(echo "${workloadShortName:1:$workloadShortNameLength}" | tr '[:upper:]' '[:lower:]')
    workloadShortNameFormatted=$workloadShortNameUpper$workloadShortNameLower


    if $isUkhsaGroupFormat && [ -n "$isUkhsaGroupFormat" ]
    then
        echo "Grp.Aws.Console.$workloadShortNameFormatted.$environment.$role"
    else 
        echo "WlAws$workloadShortNameFormatted$environment$role"
    fi
}


workloadName=$1
environmentType=$2
instance=$3
emailAddress=$4
opsDlEmailAddress=$5
securityDlEmailAddress=$6
Roles=$7
dnsSubDomains=$8
sesSubDomains=$9
securityClass=${10}
environmentName=${11}
subnetsTransit=${12}
cidr=${13}
vpcRequired="Yes"





# workloadName="pds"

# environmentType="development"
# instance='01'

# emailAddress="halo-np+pds-1@test-and-trace.nhs.uk"
# opsDlEmailAddress="halo-np+pds-1-operations@test-and-trace.nhs.uk"
# securityDlEmailAddress="halo-np+pds-1-security@test-and-trace.nhs.uk"

# Roles="Administrator"
# dnsSubDomains="ptest-1"
# sesSubDomains="ptest-1"
# securityClass="hello"
# subnetsTransit="hello"
# cidr="hello"
# vpcRequired="Yes"


workloadNameLowerCase=$(echo "$workloadName" | tr '[:upper:]' '[:lower:]')
opsDlMailLowerCase=$(echo "$opsDlEmailAddress" | tr '[:upper:]' '[:lower:]')
securityDlMailLowerCase=$(echo "$securityDlEmailAddress" | tr '[:upper:]' '[:lower:]')

# environment="$workloadNameLowerCase-$environmentType-$instance"
environment="$environmentName"

filename="etc/env_eu-west-2_$environment.tfvars"
echo "Creating $filename"

cat > "$filename"<< EOF
environment           = "$environment"
avm_aws_account_name  = "$environment"
avm_aws_account_email = "$emailAddress"
avm_aws_account_alias = "halo-np-$environment"
avm_org_ou_name       = "$workloadNameLowerCase"

avm_alternate_account_contacts = {
    operations = {
        emailAddress = "$opsDlMailLowerCase"
        name          = "AWS Alternate Contacts - $workloadNameLowerCase - Operations"
        phone_number  = "+442083277777"
        title         = "."
    }
    security = {
        emailAddress = "$securityDlMailLowerCase"
        name          = "AWS Alternate Contacts - $workloadNameLowerCase - Security"
        phone_number  = "+442083277777"
        title         = "."
    }
}
EOF

# # add avm_sso_associations to the tfvars file
# if([ -n "$roles" ] )
# then
#     IFS=',' read -ra rolesSeperated <<< "$roles"

#     avmSsoAssociations=()

#     for role in "${rolesSeperated[@]}"
#     do
#         awsAccountGroupName=$(getAwsAccountGroupName "$workloadShortName" "development" "$role" true  )
#         avmSsoAssociation=("\"$awsAccountGroupName\" = [ \"$role\" ]")
#         avmSsoAssociations+=("$avmSsoAssociation")
#     done

#     {
#         echo " ";
#         echo "avm_sso_associations = {";
#      } >> "etc/env_eu-west-2_$environment.tfvars"
     
#     for avmSsoAssociation in "${avmSsoAssociations[@]}"
#     do
#         echo "    $avmSsoAssociation" >> "etc/env_eu-west-2_$environment.tfvars"
#     done

#     echo "}" >>  "etc/env_eu-west-2_$environment.tfvars"
# fi

# # add avm_aws_account_ses_subdomains to the tfvars file

# if([ -n "$sesSubDomains" ] )
# then

#     IFS=',' read -ra sesSubDomainsSeperated <<< "$sesSubDomains"

#     {
#         echo " ";
#         echo "avm_aws_account_ses_subdomains = {";
#         # echo "    \"test-and-trace.nhs.uk\" = ["; //this might be only for prod deployment
#         echo "    \"halo-np.org.uk\" = [";
#     } >> "etc/env_eu-west-2_$environment.tfvars"

#     for sesSubDomain in "${sesSubDomainsSeperated[@]}"
#     do
#         sesSubDomainLowerCase=$(echo "$sesSubDomain" | tr '[:upper:]' '[:lower:]')
#         echo "        \"$sesSubDomainLowerCase\"," >> "etc/env_eu-west-2_$environment.tfvars"
#     done



#     {
#         echo "    ]";
#         echo "}";
#     } >>  "etc/env_eu-west-2_$environment.tfvars"
# fi

# # add avm_aws_account_subdomains to the tfvars file

# if([ -n "$dnsSubDomains" ] )
# then

#     IFS=',' read -ra dnsSubDomainsSeperated <<< "$dnsSubDomains"

#     {
#         echo " ";
#         echo "avm_aws_account_subdomains = {";
#         # echo "    \"test-and-trace.nhs.uk\" = ["; //this might be only for prod deployment
#         echo "    \"halo-np.org.uk\" = [";
#      } >> "etc/env_eu-west-2_$environment.tfvars"

#     for dnsSubDomain in "${dnsSubDomainsSeperated[@]}"
#     do
#         dnsSubDomainLowerCase=$(echo "$dnsSubDomain" | tr '[:upper:]' '[:lower:]')
#         echo "        \"$dnsSubDomainLowerCase\"," >> "etc/env_eu-west-2_$environment.tfvars"
#     done

#     {
#         echo "    ]";
#         echo "}";
#      } >>  "etc/env_eu-west-2_$environment.tfvars"
# fi

# # add avm_vpcs to the tfvars file

# if [[ "$vpcRequired" == "Yes" ]]
# then
# { 
#     echo " ";
#     echo " ";
#     echo "avm_vpc = {";
#     echo "    main = {";
#     echo "        subnetsTransit = \"$subnetsTransit\"";
#     echo "        vpc_cidr        = \"$cidr\"";
#     echo "    }";
#     echo "}"
# } >> "etc/env_eu-west-2_$environment.tfvars"
# fi

# # add others to the tfvars file


# if [[ "$securityClass" == "Non-Live" ]]
# then
# { 
#     echo "" ; 
#     echo "avm_auto_shutdown_enabled       = true"; 
#     echo "config_kms_key_deletion_enabled = false"; 
# } >> "etc/env_eu-west-2_$environment.tfvars"
# fi