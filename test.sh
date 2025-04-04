#!/bin/bash
# echo "Createing and reading a file" 


# name=Paul
# lastName=Walkington

# # echo $name
# # echo $lastName

# cat <<EOF > etc/variables.tf
# $name
# $lastName
# EOF

# value="`cat etc/variables.tf`"
# echo "$value"


json="{\"name\":\"Paul\",\"lastName\":\"Walkington\"}"


echo $json

echo '{"fruit":{"name":"apple","color":"green","price":1.20}}' | jq '.'

echo "$(echo "$json" | jq -r '.name')"