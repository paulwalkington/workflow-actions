#!/bin/bash

function haveAwsGroupNameBeenCreated () {
    groupName=$1
    # groupName="Grp.Aws.Console.Foo.prod.18.Administrator1"
    waitTimeInSeconds=2
    maxWaitTimeInSeconds=4

    totalTimeWaitedInSeconds=0
    groupFound=false

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

        sleep $waitTimeInSeconds
        totalTimeWaitedInSeconds=$((totalTimeWaitedInSeconds + waitTimeInSeconds))
    done

    if $groupFound; then
        echo "Group found: $groupName"
        exit 0
    else
        echo "Group not found: $groupName"
        exit 1
    fi
}

function haveAwsGroupNamesBeenCreated (){
    groupNames=$1
    IFS=',' read -ra groupNamesSeparated <<< "$groupNames"

    for groupName in "${groupNamesSeparated[@]}"; do
        haveAwsGroupNameBeenCreated "$groupName"
        if [ $? -ne 0 ]; then
            echo "Group $groupName not found."
            exit 1
        fi
    done

    echo "All groups found successfully."
    exit 0

}

