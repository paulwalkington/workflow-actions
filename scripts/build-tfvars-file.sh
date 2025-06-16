#!/bin/bash

source ./scripts/create-aws-group-name.sh

function createEmailAddress () {
    mailDomain=$1
    awsAccountName=$2
    
    prefix="halo-np+"
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
awsAccountGroupNames=${3}
opsDlEmailAddress=$4
securityDlEmailAddress=$5
roles=$6
dnsSubDomains=$7
sesSubDomains=$8
terraformEnvironment=$9
subnetsTransit=${10}
cidr=${11}





# workloadShortName="pds"

# environmentType="tooling"
# awsAccountGroupNames="Grp.Aws.Console.Foo.dev.13.Administrator,Grp.Aws.Console.Foo.dev.13.Billing"

# emailAddress="halo-np+pds-1@test-and-trace.nhs.uk"
# opsDlEmailAddress="halo-np+pds-1-operations@test-and-trace.nhs.uk"
# securityDlEmailAddress="halo-np+pds-1-security@test-and-trace.nhs.uk"

# roles="Administrator"
# dnsSubDomains="ptest-1"
# sesSubDomains="ptest-1"
# terraformEnvironment="stuff"
# subnetsTransit="subnetsTransithello"
# cidr="cidrhello"


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

# add avm_sso_associations to the tfvars file

# this is setting Input Field Separator to a comma so that we can split the roles string into an array
IFS=',' read -ra awsAccountGroupNamesSeparated <<< "$awsAccountGroupNames"


for awsAccountGroupName in "${awsAccountGroupNamesSeparated[@]}"
do
    IFS='.' read -ra awsAccountGroupNameParts <<< "$awsAccountGroupName"
    role=${awsAccountGroupNameParts[${#awsAccountGroupNameParts[@]} - 1]}

    avmSsoAssociation=("\"$awsAccountGroupName\" = [ \"$role\" ]")
    avmSsoAssociations+=("$avmSsoAssociation")
done


{
    echo " ";
    echo "avm_sso_associations = {";
} >> "$filename"
     
for avmSsoAssociation in "${avmSsoAssociations[@]}"
do
    echo "    $avmSsoAssociation" >> "$filename"
done

echo "}" >>  "$filename"


# add avm_aws_account_ses_subdomains to the tfvars file

if([ -n "$sesSubDomains" ] )
then

    # this is setting Input Field Separator to a comma so that we can split the sesSubDomains string into an array
    IFS=',' read -ra sesSubDomainsSeparated <<< "$sesSubDomains"

    {
        echo " ";
        echo "avm_aws_account_ses_subdomains = {";
        # echo "    \"test-and-trace.nhs.uk\" = ["; //this might be only for prod deployment
        echo "    \"halo-np.org.uk\" = [";
    } >> "$filename"

    for sesSubDomain in "${sesSubDomainsSeparated[@]}"
    do
        sesSubDomainLowerCase=$(echo "$sesSubDomain" | tr '[:upper:]' '[:lower:]')
        echo "        \"$sesSubDomainLowerCase\"," >> "$filename"
    done



    {
        echo "    ]";
        echo "}";
    } >>  "$filename"
fi

# add avm_aws_account_subdomains to the tfvars file

if([ -n "$dnsSubDomains" ] )
then

    # this is setting Input Field Separator to a comma so that we can split the dnsSubDomains string into an array
    IFS=',' read -ra dnsSubDomainsSeparated <<< "$dnsSubDomains"

    {
        echo " ";
        echo "avm_aws_account_subdomains = {";
        # echo "    \"test-and-trace.nhs.uk\" = ["; //this might be only for prod deployment
        echo "    \"halo-np.org.uk\" = [";
     } >> "$filename"

    for dnsSubDomain in "${dnsSubDomainsSeparated[@]}"
    do
        dnsSubDomainLowerCase=$(echo "$dnsSubDomain" | tr '[:upper:]' '[:lower:]')
        echo "        \"$dnsSubDomainLowerCase\"," >> "$filename"
    done

    {
        echo "    ]";
        echo "}";
     } >>  "$filename"
fi

# add avm_vpcs to the tfvars file
{ 
    echo " ";
    echo " ";
    echo "avm_vpcs = {";
    echo "    main = {";
    echo "        subnets_transit = \"$subnetsTransit\"";
    echo "        vpc_cidr        = \"$cidr\"";
    echo "    }";
    echo "}"
} >> "$filename"


case $environmentType in
    (dev|test|sandbox|tooling) 
    { 
    echo "" ; 
    echo "avm_auto_shutdown_enabled       = true"; 
    echo "config_kms_key_deletion_enabled = false"; 
} >> "$filename";; # OK
esac