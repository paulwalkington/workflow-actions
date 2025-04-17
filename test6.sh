a="12"

c="false"
c=$([ -n "$a" ] && echo "true" || echo "false")

# c=$([ $a=="" ]; echo "false" || echo "true")

echo $c