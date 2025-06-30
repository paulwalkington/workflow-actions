WORKLOAD_ENTRY="    \"paulOne\" = {}"
# FILE="env_eu-west-2_np.tfvars"
FILE="test_file.txt"
INPUT="grape"

# awk '
# BEGIN { RS=""; FS="\n"; OFS="\n" }
# /org_ous = {/ {
#     for (i=1; i<=NF; i++) {

#         if ($i ~ /"breakglass"/) {
#             # $i = "  new_value = \"new_org_value\""
#         }

#         print $i

#         # if ($i ~ /"workloads"/) {
#         #             print $i
#         # }

#         if ($i ~ /"workloads"/) { 
#             # $i = "  workloads = [paulOne]"
            
#             for (i=1; i<=NF; i++) {
                
#                 if ($i ~ /"foo"/) $i = "  Email: alex_new@example.com"
#             }
            
#         }
    
#     }
# }
# # { print $0"\n" }
# ' $FILE > temp_workloads_file.txt

# awk -v VARIABLE=$INPUT '
# BEGIN { RS=""; FS="\n"; OFS="\n" }
# /  "workloads" = {/ {
#     for (i=1; i<=NF; i++) {

#         # print $i
#         #  print VARIABLE

#         if ($i ~ /"foo"/) {
        
#            print "    \"VARIABLE\" = {}"
#             $i = "    \"VARIABLE\" = {}"

#         }

    
#     }
# }
# { print $0"\n" }
# ' $FILE  > temp_workloads_file.txt

# awk -v VARIABLE=$INPUT '
# BEGIN { RS=""; FS="\n"; OFS="\n" }
# /  "workloads" = {/ {
#     for (i=1; i<=NF; i++) {

#         if (i != 1) {

#             # print $i
#             if (i <= NF - 2) {
#                 print $i
#             }

#             # if ($i ~ /"  }"/) {
#             #  print "hello"
#             # #  print "newValue"
            
#             # #    print "    \"VARIABLE\" = {}"
#             #     # $i = "    \"VARIABLE\" = {}"

#             # }    
#         }
#     }
#     # print $0
# }
# # { print $0"\n" }
# ' $FILE  > temp_workloads_file.txt



# echo | awk -v VARIABLE=$INPUT '{ print VARIABLE }'

# awk -v VARIABLE=$INPUT '
# BEGIN { RS=""; FS="\n"; OFS="\n" }
# /  "workloads" = {/ {
#     for (i=1; i<=NF; i++) {
#         # if (i != 1 && i <= NF - 2) {
#         #         # print $i
#         #     if($i > VARIABLE) {
#         #         print $i
#         #     }
#         # }
#     }
# }
# ' $FILE  > temp_workloads_file.txt



# echo "    \"$INPUT\" = {}" >> temp_workloads_file.txt
# sort -o temp_workloads_file.txt temp_workloads_file.txt


# echo " \"workloads\" = {\n$(cat temp_workloads_file.txt)" > temp_workloads_file.txt

# echo "  } \n}" >> temp_workloads_file.txt


# ///////////

# update=$(<temp_workloads_file.txt)

# awk -v var="$update" '
# BEGIN { RS=""; FS="\n"; OFS="\n" }
# /  "workloads" = {/ 
# {print var; next} {print $0"\n"}
# # { print $0"\n" }
# ' $FILE  > temp_workloads_file_2.txt

