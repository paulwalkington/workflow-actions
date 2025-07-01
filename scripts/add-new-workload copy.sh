#!/bin/bash

function addNewWorkload () {
    input_file="$1"
    new_workload_name=$2
    temp_file="updated_test_file.txt"
    temp_workloads_file="temp_workloads_file.txt"

    # extract workload values to temp file
    awk '
    BEGIN { RS=""; FS="\n"; OFS="\n" }
    /  "workloads" = {/ {
        for (i=1; i<=NF; i++) {
            if ($i !~ "{}" && $i !~ /workloads/) {
                # skip empty lines and lines with "workloads"
                break
            }
            if ($i ~ "{}") {
                print $i
            }
        }
    }
    ' $input_file  > $temp_workloads_file

    # add new workload value to temp file
    printf "    \"$new_workload_name\" = {}" >> $temp_workloads_file
    # sort workloads value in temp file
    sort -o $temp_workloads_file $temp_workloads_file

    # format the temp file to match the expected structure
    printf "  \"workloads\" = {\n$(cat $temp_workloads_file)" > $temp_workloads_file
    printf "\n  } \n}" >> $temp_workloads_file



    # This is still deleting extra stuff after workloads if there is no space
    # e.g. root_aws_account_id

    # replace the workloads section in the original file with the updated temp file and save to new temp file
    awk -v temp_workloads_file=${temp_workloads_file} '
    BEGIN { RS=""; FS="/n"; OFS="/n" }
    {
        if ($0 ~ /  "workloads" = {/) {

            # while ((getline line < temp_workloads_file) > 0) {
            #     print line
            # }

            for (i=1; i<=NF; i++) {
                print $i

                if()

            }

        } 
        # else {
        #     print $0"\n" 
        # }
    }
    ' $input_file > $temp_file

# read in the input file and replace the workloads block with the workloads block from the file temp_workloads_file while maintaining the




    # replace original file
    # mv $temp_file $input_file

    # clean up temp files
    # rm -f $temp_workloads_file
}


