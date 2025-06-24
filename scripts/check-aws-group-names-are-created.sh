#!/bin/bash

maxWaitTimeInSeconds=2700
totalTimeWaitedInSeconds=0
waitTimeInSeconds=120

function hasAwsGroupNameBeenCreated () {
    groupName=$1

    groupFound=false

    echo "Checking for group with groupName [$groupName]" >&2

    while [ $totalTimeWaitedInSeconds -lt $maxWaitTimeInSeconds ]; do

        
        aws identitystore list-groups --region eu-west-2 --identity-store-id d-9c67117535 --no-paginate > groups.txt

        if grep -q "$groupName" groups.txt; then
            groupFound=true
            echo "Group with groupName [$groupName] found" >&2
            break
        else
            echo "Group [$groupName] not found, retrying in $waitTimeInSeconds seconds..." >&2
        fi

        sleep $waitTimeInSeconds
        totalTimeWaitedInSeconds=$((totalTimeWaitedInSeconds + waitTimeInSeconds))
    done


    if [ "$groupFound" = true ]; then
        echo "Group with groupName [$groupName] found"
        exit 0
    else
        echo "Group with groupName [$groupName] not found after waiting $totalTimeWaitedInSeconds seconds"
        exit 1
    fi
}

function haveAwsGroupNamesBeenCreated (){
    groupNames=$1

    echo "Checking if AWS group names have been created: $groupNames"

    IFS=',' read -ra groupNamesSeparated <<< "$groupNames"

    for groupName in "${groupNamesSeparated[@]}"; do
        groupFound=$(hasAwsGroupNameBeenCreated "$groupName")

        if [ $? -ne 0 ]; then
            echo "Group $groupName not found."
            exit 1
        else
            echo "Group $groupName found."
        fi
    done

    echo "All groups found successfully."

}

