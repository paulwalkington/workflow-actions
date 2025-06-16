#!/bin/bash

function hasAwsGroupNameBeenCreated () {
    groupName=$1
    # groupName="Grp.Aws.Console.Foo.prod.18.Administrator1"
    waitTimeInSeconds=2
    maxWaitTimeInSeconds=4

    totalTimeWaitedInSeconds=0
    groupFound=false

    echo "hello"

    echo "Checking for group with groupName [$groupName]"

    while [ $totalTimeWaitedInSeconds -lt $maxWaitTimeInSeconds ]; do

        
        # aws identitystore list-groups --region eu-west-2 --identity-store-id d-9c67117535 --no-paginate > groups.txt

        # if grep -q "$groupName" groups.txt; then
        #     groupFound=true
        #     echo "Group with groupName [$groupName] found"
        #     break
        # else
        #     echo "Group not found, retrying in $waitTimeInSeconds seconds..."
        # fi

        groupFound=true


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

haveAwsGroupNamesBeenCreated "someName,bill"

