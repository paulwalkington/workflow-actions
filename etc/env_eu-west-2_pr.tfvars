environment = "np"

aws_account_root_email = {
  audit    = "halo-np+audit@test-and-trace.nhs.uk"
  network  = "halo-np+network@test-and-trace.nhs.uk"
  primary  = "svc_aws_2@test-and-trace.nhs.uk"
  security = "halo-np+security@test-and-trace.nhs.uk"
  shared   = "halo-np+shared@test-and-trace.nhs.uk"
}

org_delegated_administrators = {
  global = {
    network = [
      "ipam.amazonaws.com",
    ]

    security = [
      "account.amazonaws.com",
      "config.amazonaws.com",
      "config-multiaccountsetup.amazonaws.com",
      "detective.amazonaws.com",
      "fms.amazonaws.com",
      "inspector2.amazonaws.com",
      "ssm.amazonaws.com",
      "storage-lens.s3.amazonaws.com",
    ]
  }

  regional = {
    security = [
      "guardduty.amazonaws.com",
    ]
  }
}

org_cidr = "10.0.0.0/9"

additional_org_cidrs = {
  "10.128.0.0/9" = "Azure"
}

org_ous = {
  "backup"     = {}
  "breakglass" = {}
  "core"       = {}
  "graveyard"  = {}
  "migration"  = {}
  "network"    = {}

  "workloads" = {
    "paulboo" = {}
  } 
}
##
# AHA (AWS Health Aware)
##

aha = {
  enabled = true

  events_search_back_hours = 1

  health_event_types = [
    "accountNotification",
    "issue",
    "scheduledChange",
  ]
}

org_security_noreply_email   = "no-reply@security.halo-np.org.uk"
org_security_xacct_role_name = "HaloOrgSecurityCrossAccount"

# This is an example
#root_ses_rfc2142_sns_topic_external_subscribers = [
#  {
#    protocol               = "https"
#    endpoint               = "https://api.opsgenie.com/v1/json/amazonsns?apiKey=<key>"
#    endpoint_auto_confirms = "true"
#  }
#]

##
# Alerts
##

aggregated_alerts_cwslack = {
  channel  = "#aws-alerts"
  enabled  = true
  hook_url = "https://hooks.slack.com/services/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"
}

codecommit_cwslack = {
  enabled  = "false"
  channel  = "#aws-codecommit-lz"
  hook_url = ""
}

primary_alerts_chatbot = {
  enable             = true
  slack_channel_id   = "C01RPCDMU30"
  slack_workspace_id = "T019X3MSH9Q"
}

##
# Security Route53
##

security_domain_enable_ses = true

##
# IAM
##

primary_user_groups = {
  Administrators = [
  ]

  Billing = [
  ]
}

##
# Shared
##

shared_vpc_cidr = "10.100.0.0/16"

shared_transit = {
  subnets_newbits     = 12
  subnets_netnum_root = 0
}

shared_route53_resolver_subnets = {
  count       = 3
  newbits     = 12
  netnum_root = 4064
}

##
# Network
##

network_vpc_cidr = "100.64.0.0/16"

network_transit = {
  subnets_newbits     = 12
  subnets_netnum_root = 0
}

network_nat = {
  gateway_count       = 3
  subnets_newbits     = 12
  subnets_netnum_root = 3
}

network_firewall = {
  enable                             = true
  default_route_enable               = true
  east_west_route_enable             = true
  gwlb_egress_enable                 = true
  count                              = 3
  bgp_asn                            = 65254
  mgmt_subnets_newbits               = 12
  mgmt_subnets_netnum_root           = 6
  data_subnets_newbits               = 12
  data_subnets_netnum_root           = 9
  vpn_subnets_newbits                = 12
  vpn_subnets_netnum_root            = 15
  bastion_subnets_newbits            = 12
  bastion_subnets_netnum_root        = 18
  bastion_asg_size_desired_on_create = 1
  bastion_asg_size_max               = 1
  bastion_asg_size_min               = 1
  instance_type                      = "m5.xlarge"
  bastion_instance_type              = "t2.medium"
  ami_name                           = "PanOS-10.0.2-CustomImage-22247"
  ami_build_dir                      = "ami_build"
  ami_build_user                     = "ssm-user"
  seed_ami_name                      = "PA-VM-AWS-10.1.14-h8-0825b781-215f-4686-8da2-b95275cc8dd0"
  product_code                       = "hd44w1chf26uv4p52cdynb2o"
  vm_series_plugin_version           = "vm_series-2.1.5"
  image_version                      = "10.1.14"
  vm_series_software_version         = "PanOS_vm-10.1.14"
  vm_series_upgrade_content          = true
  vm_series_upgrade_antivirus        = true
  vm_series_upgrade_global_protect   = true
  vm_series_upgrade_wildfire         = true
  bastion_ami_name                   = "amzn2-ami-hvm-2.0.20240503.0-x86_64-gp2"
  monitoring                         = true
}

network_panorama = {
  mgmt_subnets_newbits     = 12
  mgmt_subnets_netnum_root = 12
  count                    = 2
  instance_type            = "m5.4xlarge"
  volume_size              = 2048
  volume_count             = 1
  seed_ami_name            = "Panorama-AWS-10.0.2-f264c750-1102-41c9-a14d-b54ea51780e4-ami-043b1436d961638fa.4"
  product_code             = "eclz7j04vu9lf8ont8ta3n17o"
  monitoring               = true
}

network_vpn_config = [
  {
    tunnel1_inside_cidr = "169.254.18.180/30"
    tunnel2_inside_cidr = "169.254.56.108/30"
  },
  {
    tunnel1_inside_cidr = "169.254.148.144/30"
    tunnel2_inside_cidr = "169.254.179.108/30"
  },
  {
    tunnel1_inside_cidr = "169.254.110.60/30"
    tunnel2_inside_cidr = "169.254.120.236/30"
  },
]

network_gwlb = {
  east_west_subnets_newbits              = 12
  east_west_subnets_netnum_root          = 21
  east_west_endpoint_subnets_newbits     = 12
  east_west_endpoint_subnets_netnum_root = 24
  egress_subnets_newbits                 = 12
  egress_subnets_netnum_root             = 27
  egress_endpoint_subnets_newbits        = 12
  egress_endpoint_subnets_netnum_root    = 30
  ingress_subnets_newbits                = 12
  ingress_subnets_netnum_root            = 33
  ingress_endpoint_subnets_newbits       = 12
  ingress_endpoint_subnets_netnum_root   = 36
}

network_gwlb_fw_traffic = {
  traffic_subnets_newbits     = 11
  traffic_subnets_netnum_root = 39
}

network_fw_subnets = {
  public_subnets_newbits     = 11
  public_subnets_netnum_root = 42
  mgmt_subnets_newbits       = 11
  mgmt_subnets_netnum_root   = 45
}

azure_config = {
  panorama_cidrs = [
    "20.77.154.154/32",
    "51.132.157.177/32",
  ]

  firewall_cidrs = [
    "20.77.154.125/32",
  ]
}

network_azure = {
  vpn0 : {
    tunnel1_inside_cidr = "169.254.21.0/30"
    tunnel2_inside_cidr = "169.254.21.4/30"
    vng_ip              = "51.145.108.152"
    asn                 = "65284"
  },
}

##
# Route53 Root Domain
##

root_domains = {
  "halo-np.org.uk" = {
    ses_enable = false
    primary    = true
    records = [{
      name = "example.halo-np.org.uk"
      type = "A"
      ttl  = 300

      records = [
        "127.0.0.1",
      ]
    }]
  }
}

network_dx_gateways = {
  # null indicates no direct connect gateway should be created, see both aws_dx_gateway*.tf
  ukhsa-datacenters : {
    asn = null
    allowed_prefixes = [
      "172.25.128.0/17",
      "192.168.0.0/20",
      "192.168.64.0/21",
      "192.168.72.0/22",
      "192.168.76.0/23",
      "172.31.128.0/18",
      "192.168.78.0/24",
      "192.168.128.0/20",
      "192.168.248.0/24",
    ]
  }
}

# Note, this also includes transit gateway routing
network_vpc_routing = {
  ndrs : {
    # use a transit gateway attachment that *isn't* associated to a tgw route table, for testing.
    id = null
    # "192.168.0.0/20" should remain as the first element, for DEPENDENCY in ec2_transit_gateway_routes_all_spokes.tf    
    cidrs = [
      "192.168.0.0/20",
      "192.168.64.0/21",
      "192.168.72.0/22",
      "192.168.76.0/23",
      "192.168.78.0/24",
      "192.168.128.0/20",
      "192.168.248.0/24",
    ]
    cidr = "192.168.0.0/16"
  }
  edap1bwsprod : {
    id    = null
    cidrs = []
    cidr  = "172.31.128.0/18"
  }
}

pdns_ip_addresses = [
  "25.25.25.25",
  "25.26.27.28",
]

aadds_ip_addresses = [
  "10.129.5.4",
  "10.129.5.5",
]

ad_domain = "int.nihp.nhs.uk."

#Shared Subnets
subnet_id = ["subnet-012467aea8120a663", "subnet-07bb53e1ccb3369d1", "subnet-03234649d70b929fd" ]

###
# Logging
###

cloudwatch_logs_notification_prefixes = [
  "apigateway",
  "transfer",
  "workspaces-login",
]

audit_cloudwatch_firehose_enable    = true
network_cloudwatch_firehose_enable  = true
primary_cloudwatch_firehose_enable  = true
security_cloudwatch_firehose_enable = true
shared_cloudwatch_firehose_enable   = true

##
# Microsoft Sentinel Log Collection
##

sentinel_ukhsa = {
  aws_account_id = "197857026523"
  external_id    = "00b76c69-3ade-4521-a926-b25cda8e6f5c"
}

##
# Landing Zone Pipelines (Primary Addon)
##

lzp_github = {
  organization                  = "test-and-trace"
  repo_name                     = "halo-landingzone-aws"
  branch                        = "develop"
  deploy_key_ssm_parameter_name = "LandingZoneGitHubRSA"
}

lzp_chatbot = {
  enable             = true
  slack_channel_id   = "C01J4HFE9S9"
  slack_workspace_id = "T019X3MSH9Q"
}

lzp_docker_image = {
  name    = "run/terraform"
  version = "1.0.0"
}

lzp_sfn_concurrency = 0
lzp_sfn_schedule    = "cron(0 9 * * ? *)"

lzp_tfr_provider_mirror_enable = true

##
# TFR (Shared Addon)
##

tfr_public_api_enable  = true
tfr_private_api_enable = true

# The parameter names mentioned here are identical to what is in scripts/terraformrc.sh
# If this variable changes, please update that script!
tfr_config = {
  enabled = true

  ssm_parameter_names = {
    hostname   = "TfrHostname"
    lz_api_key = "TfrLzApiKey"
  }
}

tfr_api_gateway_endpoint_subnets = {
  count       = 3
  newbits     = 12
  netnum_root = 4051
}

tfr_private_lb_subnets = {
  count       = 3
  newbits     = 12
  netnum_root = 4048
}

tfr_public_lb_subnets = {
  count       = 3
  newbits     = 12
  netnum_root = 4045
}

tfr_modules_chatbot = {
  enable             = true
  slack_channel_id   = "C05E7KXNQJ3" # #aws-builds-np channel
  slack_workspace_id = "T019X3MSH9Q"
}

tfr_modules_docker_image = {
  name    = "run/terraform"
  version = "1.0.0"
}

tfr_modules_github = {
  organization                  = "test-and-trace"
  repo_name                     = "halo-terraform-modules"
  branch                        = "develop"
  deploy_key_ssm_parameter_name = "LandingZoneGitHubRSA"
}

tfr_modules_subnets = {
  count       = 3
  newbits     = 12
  netnum_root = 4054
}

config_kms_key_deletion_enabled = false

# NOTE: The Opsgenie endpoints are different depending on the integration
# target, so this is specifically for SNS based alerts...
primary_alerts_opsgenie_sns = {
  enable               = true
  endpoint_critical    = "https://api.eu.opsgenie.com/v1/json/amazonsns?apiKey=77571f9e-6a81-4e18-8d3b-06091d2a9f93"
  endpoint_noncritical = "https://api.eu.opsgenie.com/v1/json/amazonsns?apiKey=888774a3-37a1-4426-b2aa-c6820aa68174"
}

##
# S3 Storage Lens
##

# The documentation on this is so unutterably poor, both in API and CloudFormation documentation
# that it's still not completely clear how this works. In short, if you want Advanced Metrics
# on, then set account_level *and* bucket_level to true, otherwise set them false. If they
# differ the API will throw a GeneralServiceException.
#
# We are not ready to provide Prefix Level Aggregation support here because it's turtles all the way down.
s3_storage_lens_org_default_configuration_options = {
  account_level_activity_metrics = true
  bucket_level_activity_metrics  = true
  export_cloudwatch_metrics      = true
}

##
# Azure Data Factory
##

azure_data_factory_enabled = true

##
# IPAM
##

ipam_available_cidr_ranges = {
  main = [
    "10.0.0.0/9",
  ]
  ukhsa = [
    "172.25.128.0/17",
    "172.26.128.0/17",
  ]
}

ipam_api_users = {
  az_automation_engine = {}
}

##
# OpsGenie - new integration
##

opsgenie_api = {
  key        = null
  ssm        = "/opsgenie/api_key"
  ssm_create = true
  url        = "api.eu.opsgenie.com"
}

tfr_opsgenie_integrations_sns = {
  tfr_noncritical = {
    alert_priority = "P4"

    # Automatic Integration
    # TESTING - removed as opsgenie has been discontinued, and causing Pipelines to fail
    team_name = null

    # Manual Integrations
    api_keys = []
  }
}

##
# Noti - Notification Scheduler
##

notification_schedules = {
  managed-desktops-jira-api-key = { deadline = "2024-06-02", title = "Renew Jira API key for in Dev and Test", description = "Renew Jira API key for svc_AwsHosting service account in test2 and test3 jira environments and update ssm param in MDSK Tooling account.." },
  np-identity-centre-scim       = { deadline = "2024-11-15", title = "Renew Identity Centre SCIM access token in NP", description = "Renew SCIM access token in NP - HAH-5949" },
  np-managed-desktops-saml      = { deadline = "2026-11-27", title = "Renew SAML Certificate in Managed Desktops Test", description = "Renew the SAML Signing Certificate for the Managed Desktops Test Enterprise Application in Azure, and update it in the MDSK Testing2 AWS account" },
  np-contact-centre-saml        = { deadline = "2026-11-29", title = "Renew SAML Certificate in Contact Centre Test", description = "Renew the SAML Signing Certificate for the Contact Centre Test Enterprise Application in Azure, and update it in the CC Dev2 AWS account" },
}

##
# EC2 Usage Report
##

ec2_usage_report_email_subscriptions = [
  "UCPCloudOps-AWS@ukhsa.gov.uk",
]

##
# CLoudOps Email Subscriptions
##
email_subscriptions = [
  "UCPCloudOps-AWS@ukhsa.gov.uk"
]

email_subscriptions_lambda = [
  {
    protocol = "email"
    endpoint = "UCPCloudOps-AWS@ukhsa.gov.uk"
  }

]

##
# SSO
##

sso_assumable_roles = {
  "CMPTest"         = { CustomerManagedPolicy = true }
  "ApplicationUser" = {}
}

# SSO mapping/s for *audit* account only
audit_sso_associations = {
  "Grp.Aws.Console.LandingZone.NonProduction.Audit.ReadOnly" = ["ReadOnly"]
}

