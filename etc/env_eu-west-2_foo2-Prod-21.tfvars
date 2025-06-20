environment           = "foo2-Prod-21"
avm_aws_account_name  = "foo2-Prod-21"
avm_aws_account_email = "halo-np+foo2-prod-21@test-and-trace.nhs.uk"
avm_aws_account_alias = "halo-np-foo2-Prod-21"
avm_org_ou_name       = "foo2"

avm_alternate_account_contacts = {
    operations = {
        email_address = ""
        name          = "AWS Alternate Contacts - foo2 - Operations"
        phone_number  = "+442083277777"
        title         = "."
    }
    security = {
        email_address = ""
        name          = "AWS Alternate Contacts - foo2 - Security"
        phone_number  = "+442083277777"
        title         = "."
    }
}
 
avm_sso_associations = {
    "Grp.Aws.Console.Foo2.Prod.21.Administrator" = [ "Administrator" ]
    "Grp.Aws.Console.Foo2.Prod.21.Billing" = [ "Billing" ]
}
 
 
avm_vpcs = {
    main = {
        subnets_transit = ""
        vpc_cidr        = ""
    }
}
