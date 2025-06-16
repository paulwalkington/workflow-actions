#!/bin/bash


source ./scripts/create-aws-group-name.sh

awsAccountGroupName=$(createAwsAccountGroupName "workloadShortName" "environmentType" "environmentName" "role" "true"  )

sh "./scripts/check-for-group.sh" "$awsAccountGroupName"

result=$?
if [ $result -eq 0 ]; then
    echo "Group found successfully."
else
    echo "Group not found"
fi

echo "AWS Account Group Name: $awsAccountGroupName"