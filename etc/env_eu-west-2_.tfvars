environment           = ""
avm_aws_account_name  = ""
avm_aws_account_email = ""
avm_aws_account_alias = "halo-pr-"
avm_org_ou_name       = ""

avm_alternate_account_contacts = {
    operations = {
        email_address = ""
        name          = "AWS Alternate Contacts -  - Operations"
        phone_number  = "+442083277777"
        title         = "."
    }
    security = {
        email_address = ""
        name          = "AWS Alternate Contacts -  - Security"
        phone_number  = "+442083277777"
        title         = "."
    }
}
 
 
avm_vpc = {
    main = {
        subnets_transit = "2,0"
        vpc_cidr        = "172.25.128.0/17"
    }
}
