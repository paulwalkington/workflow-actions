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

echo fromJson(json)

echo $json