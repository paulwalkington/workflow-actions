          jsonString=$( jq -n \
                  --arg environment "hello" \
                  --arg avm_aws_account_name "world" \
                  --arg avm_aws_account_email "from paul" \
                  --arg avm_aws_account_alias "today" \
                  --arg avm_org_ou_name "weather" \
                  '{environment: $environment, avm_aws_account_name: $avm_aws_account_name, avm_aws_account_email: $avm_aws_account_email,
                   avm_aws_account_alias: $avm_aws_account_alias, avm_org_ou_name: $avm_org_ou_name}' )

          echo "---------jsonString---------"
          echo $jsonString
          echo "---------jsonString---------"

          # encodedJson=echo $jsonString | base64
          encodedJson=$(echo $jsonString | base64)

          echo "---------encoded---------"
          echo $encodedJson
          echo "---------encoded---------"