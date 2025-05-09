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


vend_workload_name=$1
vend_environment_type=$2
vend_instance=$3
email_address=$4
ops_dl_email_address=$5
security_dl_email_address=$6
vend_roles=$7
dns_sub_domains=$8
ses_sub_domains=$9
vend_security_class=${10}
environment_name=${11}
subnets_transit=${12}
cidr=${13}
vpcRequired="Yes"





# vend_workload_name="pds"

# vend_environment_type="development"
# vend_instance='01'

# email_address="halo-np+pds-1@test-and-trace.nhs.uk"
# ops_dl_email_address="halo-np+pds-1-operations@test-and-trace.nhs.uk"
# security_dl_email_address="halo-np+pds-1-security@test-and-trace.nhs.uk"

# vend_roles="Administrator"
# dns_sub_domains="ptest-1"
# ses_sub_domains="ptest-1"
# vend_security_class="hello"
# subnets_transit="hello"
# cidr="hello"
# vpcRequired="Yes"


workloadNameLowerCase=$(echo "$vend_workload_name" | tr '[:upper:]' '[:lower:]')
opsDlMailLowerCase=$(echo "$ops_dl_email_address" | tr '[:upper:]' '[:lower:]')
securityDlMailLowerCase=$(echo "$security_dl_email_address" | tr '[:upper:]' '[:lower:]')

# environment="$workloadNameLowerCase-$environmentType-$instance"
environment="$environment_name"

filename="etc/env_eu-west-2_$environment.tfvars"
echo "Creating $filename"

cat > "$filename"<< EOF
environment           = "$environment"
avm_aws_account_name  = "$environment"
avm_aws_account_email = "$email_address"
avm_aws_account_alias = "halo-np-$environment"
avm_org_ou_name       = "$workloadNameLowerCase"

avm_alternate_account_contacts = {
    operations = {
        email_address = "$opsDlMailLowerCase"
        name          = "AWS Alternate Contacts - $workloadNameLowerCase - Operations"
        phone_number  = "+442083277777"
        title         = "."
    }
    security = {
        email_address = "$securityDlMailLowerCase"
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
#     echo "        subnets_transit = \"$subnets_transit\"";
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