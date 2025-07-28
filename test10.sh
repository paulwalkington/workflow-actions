#!/bin/bash

vend_instance="hello12674"

if [[ ! "$vend_instance" =~ ^[a-z0-9]{0,10}$ ]]; then
    echo "Error: vend_instance must be between 0 and 10 lower case characters or numbers, and contain no spaces."
    exit 1
fi

vend_workload_tags="Department:departmentName,Team:teamName,Support:supportLevel,DataClassification:dataClassification"  
# vend_workload_tags="Department:Engineering,Team:DevOps,Support:High,DataClassification:Confidential"


# [[:space:]]
# if [[ ! "$vend_workload_tags" =~ ^Department:[a-zA-Z_0-9]+,Team:[a-zA-Z_0-9-_+:\/]+,Support:[a-zA-Z]+,DataClassification:[a-zA-Z]+$ ]]; then
if [[ ! "$vend_workload_tags" =~ ^Department:[a-zA-Z_0-9]+,Team:[a-zA-Z0-9_-+:\/]+,Support:[a-zA-Z]+,DataClassification:[a-zA-Z]+$ ]]; then
    echo "Error: vend_workload_tags does not match the required format."
    exit 1
fi

