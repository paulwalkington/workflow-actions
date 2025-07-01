WORKLOAD_ENTRY="    \"paulOne\" = {}"
# FILE="env_eu-west-2_np.tfvars"
FILE="test_file.txt"
INPUT="grape"

awk '
BEGIN { RS=""; FS="\n"; OFS="\n" }
/CustomerID: 001/ {
    for (i=1; i<=NF; i++) {
        if ($i ~ /Contact:/) { inContactBlock = 1 }
        if (inContactBlock) {
            if ($i ~ /Email:/) $i = "  Email: alex_new@example.com"
            if ($i ~ /Phone:/) { $i = "  Phone: 111-222-3333"; inContactBlock = 0 }
        }
    }
}
/Plan: Premium/ {
    for (i=1; i<=NF; i++) {
        if ($i ~ /Billing:/) { inBillingBlock = 1 }
        if (inBillingBlock) {
            if ($i ~ /Last Payment:/) $i = "  Last Payment: $150"
            if ($i ~ /Due Date:/) { $i = "  Due Date: 2024-05-10"; inBillingBlock = 0 }
        }
    }
}
{ print $0"\n" }
' $FILE > temp_file.txt