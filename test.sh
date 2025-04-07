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


# json="{\"name\":\"Paul\",\"lastName\":\"Walkington\"}"


# echo $json | jq '.'


# echo "$(echo "$json" | jq -r '.name')"

json2="{
    "alternate_contacts": {
      "operations": {
        "email_address": "aws-hosting-devbox-operations@test-and-trace.nhs.uk",
        "name": "AWS",
        "phone_number": "+442083277777",
        "title": "."
      },
      "security": {
        "email_address": "aws-hosting-devbox-security@test-and-trace.nhs.uk",
        "name": "AWS",
        "phone_number": "+442083277777",
        "title": "dev"
      }
    },
    "auto_shutdown_enabled": true,
    "avm_aws_account_alias": "halo-np-devbox-nl3",
    "avm_aws_account_email": "halo-np+ptest-1@test-and-trace.nhs.uk",
    "avm_aws_account_name": "ptest-1",
    "avm_org_ou_name": "foo",
    "avm_subdomain": {
      "children": [
        "ptest-1"
      ],
      "parent": "halo-np.org.uk"
    },
    "environment": "ptest-1",
    "roles": "Administrator",
    "vpc-config": {
      "requestor": "cvm-burendo",
      "vpc-size": "Medium",
      "vpc-type": "ukhsa"
    }
  }"

json3='{ "alternate_contacts": { "operations": { "email_address": "aws-hosting-devbox-operations@test-and-trace.nhs.uk", "name": "AWS", "phone_number": "+442083277777", "title": "." }, "security": { "email_address": "aws-hosting-devbox-security@test-and-trace.nhs.uk", "name": "AWS", "phone_number": "+442083277777", "title": "dev" } }, "auto_shutdown_enabled": true, "avm_aws_account_alias": "halo-np-devbox-nl3", "avm_aws_account_email": "halo-np+ptest-1@test-and-trace.nhs.uk", "avm_aws_account_name": "ptest-1", "avm_org_ou_name": "foo", "avm_subdomain": { "children": [ "ptest-1" ], "parent": "halo-np.org.uk" }, "environment": "ptest-1", "roles": "Administrator", "vpc-config": { "requestor": "cvm-burendo", "vpc-size": "Medium", "vpc-type": "ukhsa" } }'

echo $json3 | jq '.["environment"]'