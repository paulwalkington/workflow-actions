#!/bin/bash

function createAwsAccountGroupName () {
    workloadShortName=$1
    environmentType=$2
    environmentName=$3
    role=$4

    workloadShortNameLength=${#workloadShortName}

    workloadShortNameUpper=$(echo "${workloadShortName:0:1}" | tr '[:lower:]' '[:upper:]')
    workloadShortNameLower=$(echo "${workloadShortName:1:$workloadShortNameLength}" | tr '[:upper:]' '[:lower:]')
    workloadShortNameFormatted=$workloadShortNameUpper$workloadShortNameLower

    environment="${environmentType}"

    if [ -n "$environmentName" ]; then
        environment="$environmentType.$environmentName"
    fi

    echo "Grp.Aws.Console.$workloadShortNameFormatted.$environment.$role"
}

function createAwsAccountGroupNames () {
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

    awsAccountGroupNamesJoined=$(IFS=','; echo "${awsAccountGroupNames[*]}")
    echo "$awsAccountGroupNamesJoined"
}

