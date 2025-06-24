environment           = "stuff"
avm_aws_account_name  = "stuff"
avm_aws_account_email = "halo-np+stuff@test-and-trace.nhs.uk"
avm_aws_account_alias = "halo-np-stuff"
avm_org_ou_name       = "pds"

avm_alternate_account_contacts = {
    operations = {
        email_address = "halo-np+pds-1-operations@test-and-trace.nhs.uk"
        name          = "AWS Alternate Contacts - pds - Operations"
        phone_number  = "+442083277777"
        title         = "."
    }
    security = {
        email_address = "halo-np+pds-1-security@test-and-trace.nhs.uk"
        name          = "AWS Alternate Contacts - pds - Security"
        phone_number  = "+442083277777"
        title         = "."
    }
}
 
avm_sso_associations = {
    "Grp.Aws.Console.Foo.dev.13.Administrator" = [ "Administrator" ]
    "Grp.Aws.Console.Foo.dev.13.Billing" = [ "Billing" ]
}
 
avm_aws_account_ses_subdomains = {
    "halo-np.org.uk" = [
        "ptest-1",
    ]
}
 
avm_aws_account_subdomains = {
    "halo-np.org.uk" = [
        "ptest-1",
    ]
}
 
 
avm_vpcs = {
    main = {
        subnets_transit = "subnetsTransithello"
        vpc_cidr        = "cidrhello"
    }
}

avm_auto_shutdown_enabled       = true
config_kms_key_deletion_enabled = false
