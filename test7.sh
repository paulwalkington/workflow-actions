          
name=""  
result="hello"        
          
if [[ -n "$name" ]]; then
    result="${result}.name"
fi

echo $result