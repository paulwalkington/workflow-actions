environment           = "some_environment"
avm_aws_account_name  = "some_name"
avm_aws_account_email = "some_email_address"
avm_aws_account_alias = "halo-pr-some_environment"
avm_org_ou_name       = "some_workload_short_name1"

avm_alternate_account_contacts = {
    operations = {
        email_address = "some_ops_dl_mail"
        name          = "AWS Alternate Contacts - some_workload_short_name1 - Operations"
        phone_number  = "+442083277777"
        title         = "."
    }
    security = {
        email_address = "some_security_dl_mail"
        name          = "AWS Alternate Contacts - some_workload_short_name1 - Security"
        phone_number  = "+442083277777"
        title         = "."
    }
}
 
avm_sso_associations = {
    "Grp.Aws.Console.Aai.Development.Administrator" = [ "Administrator" ]
    "Grp.Aws.Console.Aai.Development.ReadOnly" = [ "ReadOnly" ]
    "Grp.Aws.Console.Aai.Development.ApplicationUser" = [ "ApplicationUser" ]
}
 
avm_aws_account_ses_subdomains = {
    "test-and-trace.nhs.uk" = [
        "foo",
        "bar",
    ]
}
 
avm_aws_account_subdomains = {
    "test-and-trace.nhs.uk" = [
        "foo",
        "bar",
    ]
}
