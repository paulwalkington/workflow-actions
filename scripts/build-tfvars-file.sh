#!/usr/bin/env bash

function createAwsAccountGroupName () {
    workloadShortName=$1
    environmentType=$2
    environmentName=$3
    role=$4
    isUkhsaGroupFormat=$5

    workloadShortNameLength=${#workloadShortName}

    workloadShortNameUpper=$(echo "${workloadShortName:0:1}" | tr '[:lower:]' '[:upper:]')
    workloadShortNameLower=$(echo "${workloadShortName:1:$workloadShortNameLength}" | tr '[:upper:]' '[:lower:]')
    workloadShortNameFormatted=$workloadShortNameUpper$workloadShortNameLower

    environment="${environmentType}"

    if [ -n "$environmentName" ]; then
        environment="$environmentType.$environmentName"
    fi

    if $isUkhsaGroupFormat && [ -n "$isUkhsaGroupFormat" ]
    then
        echo "Grp.Aws.Console.$workloadShortNameFormatted.$environment.$role"
    else 
        echo "WlAws$workloadShortNameFormatted$environment$role"
    fi
}

function createEmailAddress () {
    mailDomain=$1
    awsAccountName=$2
    
    prefix="halo-pr+"
    prefixLength=${#prefix}
    mailDomainLength=${#mailDomain}
    awsAccountNameLength=${#awsAccountName}

     # 64 is the max length constraint in AWS
    maxEmailLength=64
    # +1 for the @

    if [ $((prefixLength + awsAccountNameLength + mailDomainLength + 1)) -gt $maxEmailLength ]; then
        awsAccountName=$(echo "$awsAccountName" | cut -c1-$((maxEmailLength - prefixLength - mailDomainLength - 1)) | tr '[:upper:]' '[:lower:]')
    else
        awsAccountName=$(echo "$awsAccountName" | tr '[:upper:]' '[:lower:]')
    fi

    echo "$prefix$awsAccountName@$mailDomain"
}


workloadShortName=$1
environmentType=$2
environmentName=$3
opsDlEmailAddress=$4
securityDlEmailAddress=$5
roles=$6
dnsSubDomains=$7
sesSubDomains=$8
securityClass=$9
terraformEnvironment=${10}
subnetsTransit=${11}
cidr=${12}





# workloadShortName="pds"

# environmentType="test"
# environmentName='01'

# emailAddress="halo-np+pds-1@test-and-trace.nhs.uk"
# opsDlEmailAddress="halo-np+pds-1-operations@test-and-trace.nhs.uk"
# securityDlEmailAddress="halo-np+pds-1-security@test-and-trace.nhs.uk"

# roles="Administrator"
# dnsSubDomains="ptest-1"
# sesSubDomains="ptest-1"
# securityClass="Non-Live"
# terraformEnvironment="stuff"
# subnetsTransit="hello"
# cidr="hello"


workloadShortNameLowerCase=$(echo "$workloadShortName" | tr '[:upper:]' '[:lower:]')
opsDlMailLowerCase=$(echo "$opsDlEmailAddress" | tr '[:upper:]' '[:lower:]')
securityDlMailLowerCase=$(echo "$securityDlEmailAddress" | tr '[:upper:]' '[:lower:]')
emailAddress=$(createEmailAddress "test-and-trace.nhs.uk" "$terraformEnvironment")

filename="etc/env_eu-west-2_$terraformEnvironment.tfvars"
echo "Creating $filename"

cat > "$filename"<< EOF
environment           = "$terraformEnvironment"
avm_aws_account_name  = "$terraformEnvironment"
avm_aws_account_email = "$emailAddress"
avm_aws_account_alias = "halo-np-$terraformEnvironment"
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

# # add avm_sso_associations to the tfvars file
# if [ -n "$roles" ] 
# then
#     IFS=',' read -ra rolesSeperated <<< "$roles"

#     avmSsoAssociations=()

#     for role in "${rolesSeperated[@]}"
#     do
#         awsAccountGroupName=$(createAwsAccountGroupName "$workloadShortName" "$environmentType" "$environmentName" "$role" true  )
#         avmSsoAssociation=("\"$awsAccountGroupName\" = [ \"$role\" ]")
#         avmSsoAssociations+=("$avmSsoAssociation")
#     done

#     {
#         echo " ";
#         echo "avm_sso_associations = {";
#      } >> "$filename"
     
#     for avmSsoAssociation in "${avmSsoAssociations[@]}"
#     do
#         echo "    $avmSsoAssociation" >> "$filename"
#     done

#     echo "}" >>  "$filename"
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
#     } >> "$filename"

#     for sesSubDomain in "${sesSubDomainsSeperated[@]}"
#     do
#         sesSubDomainLowerCase=$(echo "$sesSubDomain" | tr '[:upper:]' '[:lower:]')
#         echo "        \"$sesSubDomainLowerCase\"," >> "$filename"
#     done



#     {
#         echo "    ]";
#         echo "}";
#     } >>  "$filename"
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
#      } >> "$filename"

#     for dnsSubDomain in "${dnsSubDomainsSeperated[@]}"
#     do
#         dnsSubDomainLowerCase=$(echo "$dnsSubDomain" | tr '[:upper:]' '[:lower:]')
#         echo "        \"$dnsSubDomainLowerCase\"," >> "$filename"
#     done

#     {
#         echo "    ]";
#         echo "}";
#      } >>  "$filename"
# fi

# # add avm_vpcs to the tfvars file
# { 
#     echo " ";
#     echo " ";
#     echo "avm_vpcs = {";
#     echo "    main = {";
#     echo "        subnets_transit = \"$subnetsTransit\"";
#     echo "        vpc_cidr        = \"$cidr\"";
#     echo "    }";
#     echo "}"
# } >> "$filename"


# add others to the tfvars file


if [[ "$securityClass" == "Non-Live" ]]
then
{ 
    echo "" ; 
    echo "avm_auto_shutdown_enabled       = true"; 
    echo "config_kms_key_deletion_enabled = false"; 
} >> "$filename"
fi