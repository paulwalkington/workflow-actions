a=""

c="false"
c=$([ -n "$a" ] && echo true || echo false)

# c=$([ $a=="" ]; echo "false" || echo "true")

echo $c

if [ $c==true ]; then
    echo "It was set to true"
else
    echo "It was set to false"
fi