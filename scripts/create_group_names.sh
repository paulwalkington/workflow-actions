#!/bin/bash

source ./scripts/create-aws-group-name.sh

workloadShortName=$1
environmentType=$2
environmentName=$3
roles=$4

IFS=',' read -ra rolesSeparated <<< "$roles"

awsAccountGroupNames=()

for role in "${rolesSeparated[@]}"
do
    awsAccountGroupName=$(createAwsAccountGroupName "$workloadShortName" "$environmentType" "$environmentName" "$role" "true"  )
    awsAccountGroupNames+=("$awsAccountGroupName")
done
