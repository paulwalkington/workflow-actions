environment           = "foo-Prod"
avm_aws_account_name  = "foo-Prod"
avm_aws_account_email = "halo-np+foo-prod@test-and-trace.nhs.uk"
avm_aws_account_alias = "halo-np-foo-Prod"
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
    "Grp.Aws.Console.Foo.Prod.Administrator" = [ "Administrator" ]
    "Grp.Aws.Console.Foo.Prod.Billing" = [ "Billing" ]
}
 
 
avm_vpcs = {
    main = {
        subnets_transit = ""
        vpc_cidr        = ""
    }
}
