#!/bin/bash

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