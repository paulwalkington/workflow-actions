input_file=$1
new_workload_name=$2
temp_file="updated_test_file.txt"
temp_workloads_file="temp_workloads_file.txt"

# extract workload values to temp file
awk '
BEGIN { RS=""; FS="\n"; OFS="\n" }
/  "workloads" = {/ {
    for (i=1; i<=NF; i++) {
        if ($i ~ "{}") {
            # break
            print $i
        }
        if ($i ~ "root_aws_account_id") {
            break
        }
    }
}
' $input_file  > $temp_workloads_file

# add new workload value to temp file
echo "    \"$new_workload_name\" = {}" >> $temp_workloads_file
# sort workloads value in temp file
sort -o $temp_workloads_file $temp_workloads_file

# format the temp file to match the expected structure
echo "  \"workloads\" = {\n$(cat $temp_workloads_file)" > $temp_workloads_file
echo "  } \n}" >> $temp_workloads_file



# replace the workloads section in the original file with the updated temp file and save to new temp file
awk -v temp_workloads_file=${temp_workloads_file} '
BEGIN { RS=""; FS="\n"; OFS="\n" }
{
    if ($0 ~ /  "workloads" = {/) {

        while ((getline line < temp_workloads_file) > 0) {
            print line
        }

    } else {
         print $0"\n" 
    }
}
' test_file.txt > $temp_file
# replace original file
mv $temp_file $input_file