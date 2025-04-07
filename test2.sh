 encodedJson="eyAiZW52aXJvbm1lbnQiOiAicHRlc3QtMSIsICJhdm1fYXdzX2FjY291bnRfbmFtZSI6ICJwdGVz
  dC0xIiwgImF2bV9hd3NfYWNjb3VudF9lbWFpbCI6ICJoYWxvLW5wK3B0ZXN0LTFAdGVzdC1hbmQt
  dHJhY2UubmhzLnVrIiwgImF2bV9hd3NfYWNjb3VudF9hbGlhcyI6ICJoYWxvLW5wLWRldmJveC1u
  bDMiLCAiYXZtX29yZ19vdV9uYW1lIjogImZvbyIgfQo="
echo $encodedJson 

jsonWithoutSpace=$(echo -n $encodedJson)
echo $jsonWithoutSpace 
  
json=$(echo -n $jsonWithoutSpace | base64 -d)
  
echo "$json"