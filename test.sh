#!/bin/bash
# echo "Createing and reading a file" 


# name=Paul
# lastName=Walkington

# # echo $name
# # echo $lastName

# cat <<EOF > etc/variables.tf
# $name
# $lastName
# EOF

# value="`cat etc/variables.tf`"
# echo "$value"


json="{\"name\":\"Paul\",\"lastName\":\"Walkington\"}"


echo $json | jq '.'


echo "$(echo "$json" | jq -r '.name')"

json2="{n "alternate_contacts": {n "operations": {n "email_address": "aws-hosting-devbox-operations@test-and-trace.nhs.uk",n "name": "AWS Alternate Contacts - devbox - Operations",n "phone_number": "+442083277777",n "title": "."n },n "security": {n "email_address": "aws-hosting-devbox-security@test-and-trace.nhs.uk",n "name": "AWS Alternate Contacts - devbox - Security",n "phone_number": "+442083277777",n "title": "dev"n }n },n "auto_shutdown_enabled": true,n "avm_aws_account_alias": "halo-np-devbox-nl3",n "avm_aws_account_email": "halo-np+ptest-1@test-and-trace.nhs.uk",n "avm_aws_account_name": "ptest-1",n "avm_org_ou_name": "foo",n "avm_subdomain": {n "children": [n "ptest-1"n ],n "parent": "halo-np.org.uk"n },n "environment": "ptest-1",n "roles": "Administrator",n "vpc-config": {n "requestor": "cvm-burendo",n "vpc-size": "Medium",n "vpc-type": "ukhsa"n }n}"

echo $json2 | jq '.'