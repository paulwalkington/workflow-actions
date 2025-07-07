environment           = "foo-Prod-18"
avm_aws_account_name  = "foo-Prod-18"
avm_aws_account_email = "halo-np+foo-prod-18@test-and-trace.nhs.uk"
avm_aws_account_alias = "halo-np-foo-Prod-18"
avm_org_ou_name       = "foo"

avm_alternate_account_contacts = {
    operations = {
        email_address = ""
        name          = "AWS Alternate Contacts - foo - Operations"
        phone_number  = "+442083277777"
        title         = "."
    }
    security = {
        email_address = ""
        name          = "AWS Alternate Contacts - foo - Security"
        phone_number  = "+442083277777"
        title         = "."
    }
}
 
avm_sso_associations = {
    "Grp.Aws.Console.Foo.Prod.18.Administrator" = [ "Administrator" ]
    "Grp.Aws.Console.Foo.Prod.18.Billing" = [ "Billing" ]
}
 
 
avm_vpcs = {
    main = {
        subnets_transit = ""
        vpc_cidr        = ""
    }
}
