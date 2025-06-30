# FILE="env_eu-west-2_np.tfvars"
FILE="test_file.txt"
NEW_FILE="updated_test_file.txt"
TEMP_WORKLOAD_FILE="temp_workloads_file.txt"
INPUT="bill"

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
' $FILE  > $TEMP_WORKLOAD_FILE

# add new workload value to temp file
echo "    \"$INPUT\" = {}" >> $TEMP_WORKLOAD_FILE
# sort workloads value in temp file
sort -o $TEMP_WORKLOAD_FILE $TEMP_WORKLOAD_FILE

# format the temp file to match the expected structure
echo "  \"workloads\" = {\n$(cat $TEMP_WORKLOAD_FILE)" > $TEMP_WORKLOAD_FILE
echo "  } \n}" >> $TEMP_WORKLOAD_FILE



# replace the workloads section in the original file with the updated temp file and save to new temp file
awk -v TEMP_WORKLOAD_FILE=${TEMP_WORKLOAD_FILE} '
BEGIN { RS=""; FS="\n"; OFS="\n" }
{
    if ($0 ~ /  "workloads" = {/) {

        while ((getline line < TEMP_WORKLOAD_FILE) > 0) {
            print line
        }

    } else {
         print $0"\n" 
    }
}
' test_file.txt > $NEW_FILE
# replace original file
mv $NEW_FILE $FILE