environment = "pr"

aws_account_root_email = {
  audit    = "halo-pr+audit@test-and-trace.nhs.uk"
  network  = "halo-pr+network@test-and-trace.nhs.uk"
  primary  = "svc_aws_1@test-and-trace.nhs.uk"
  security = "halo-pr+security@test-and-trace.nhs.uk"
  shared   = "halo-pr+shared@test-and-trace.nhs.uk"
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
      "guardduty.amazonaws.com",
      "inspector2.amazonaws.com",
      "ssm.amazonaws.com",
      "storage-lens.s3.amazonaws.com",
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
    "aai"    = {}
    "ace"    = {}
    "alytic" = {}
    "apim"   = {}
    "brapi"  = {}
    "c19da"  = {}
    "cc"     = {}
    "ci"     = {}
    "cims"   = {}
    "collab" = {}
    "copps"  = {}
    "covapp" = {}
    "csp"    = {}
    "cts"    = {}
    "cvtcds" = {}
    "cvtdpt" = {}
    "cvteds" = {}
    "cvtibt" = {}
    "cvtobt" = {}
    "cvtolt" = {}
    "cvtsim" = {}
    "cvtstt" = {}
    "dash"   = {}
    "depdj"  = {}
    "dhp"    = {}
    "edap"   = {}
    "edap1b" = {}
    "emph"   = {}
    "essamr" = {}
    "evo"    = {}
    "ewi"    = {}
    "fstdv"  = {}
    "genom"  = {}
    "gitpro" = {}
    "hmclf"  = {}
    "hoa"    = {}
    "homtst" = {}
    "hpepft" = {}
    "hpepsd" = {}
    "hpub"   = {}
    "hpsfda" = {}
    "hwfuc"  = {}
    "iat"    = {}
    "jup"    = {}
    "l2ss"   = {}
    "lae"    = {}
    "maps"   = {}
    "mdsk"   = {}
    "mdmpoc" = {}
    "mim"    = {}
    "onsp4"  = {}
    "pets"   = {}
    "pharm"  = {}
    "plfdup" = {}
    "ppean"  = {}
    "prvtst" = {}
    "ptarm"  = {}
    "ptsrep" = {}
    "ptvs"   = {}
    "qat"    = {}
    "qms"    = {}
    "rdm"    = {}
    "rmatch" = {}
    "rtts"   = {}
    "sfda"   = {}
    "sfolt"  = {}
    "sgsap"  = {}
    "sip"    = {}
    "skdb"   = {}
    "srs"    = {}
    "subdm"  = {}
    "supchn" = {}
    "spktel" = {}
    "sts"    = {}
    "tbgpoc" = {}
    "trws"   = {}
    "tshpc"  = {}
    "voc"    = {}
    "wpr"    = {}
    "zpaac"  = {}
  }
}

org_ous_additional_regions = {}

org_ous_core_additional_regions = [
  "eu-west-1",
]

org_ous_default_additional_regions = [
  "eu-west-1",
]

cost_allocation_tags_active = [
  "map-migrated",
]

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

##
# SES
##

org_security_noreply_email = "no-reply@security.test-and-trace.nhs.uk"
security_domain_enable_ses = true

# This is an example
#root_ses_rfc2142_sns_topic_external_subscribers = [
#  {
#    protocol               = "https"
#    endpoint               = "https://api.opsgenie.com/v1/json/amazonsns?apiKey=<key>"
#    endpoint_auto_confirms = "true"
#  }
#]

##
# Slack
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
  slack_channel_id   = "G01CH82Q0GH"
  slack_workspace_id = "T019X3MSH9Q"
}

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
  ami_name                           = "PanOS-10.0.2-CustomImage-874"
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
  volume_count             = 4
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
    "20.77.131.249/32",
    "20.77.131.144/32",
  ]

  firewall_cidrs = [
    "51.132.174.250/32",
  ]
}

network_azure = {
  vpn0 : {
    tunnel1_inside_cidr = "169.254.21.0/30"
    tunnel2_inside_cidr = "169.254.21.4/30"
    vng_ip              = "20.90.243.232"
    asn                 = "65284"
  },
  vpn1 : {
    tunnel1_inside_cidr = "169.254.22.0/30"
    tunnel2_inside_cidr = "169.254.22.4/30"
    vng_ip              = "20.90.243.204"
    asn                 = "65284"
  },
}

network_dx_gateways = {
  ukhsa-datacenters : {
    asn = 64513
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
    id = "tgw-attach-04e7e86dadd7a2362"
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

network_dx_connections_hosted = {
  colindale-pri : {
    dx_connection_id = "dxcon-fftngk8m"
    dx_gateway_name  = "ukhsa-datacenters"
    vlan             = 19
    bgp_peer_asn     = 25180
    bgp_peer_address = "100.100.0.89/30"
    bgp_address      = "100.100.0.90/30"
  }
  colindale-sec : {
    dx_connection_id = "dxcon-ffiq0qo3"
    dx_gateway_name  = "ukhsa-datacenters"
    vlan             = 12
    bgp_peer_asn     = 25180
    bgp_peer_address = "100.100.0.93/30"
    bgp_address      = "100.100.0.94/30"
  }
  porton-down-pri : {
    dx_connection_id = "dxcon-ffock2dx"
    dx_gateway_name  = "ukhsa-datacenters"
    vlan             = 372
    bgp_peer_asn     = 25180
    bgp_peer_address = "100.100.0.9/30"
    bgp_address      = "100.100.0.10/30"
  }
  porton-down-sec : {
    dx_connection_id = "dxcon-fgiznqs4"
    dx_gateway_name  = "ukhsa-datacenters"
    vlan             = 351
    bgp_peer_asn     = 25180
    bgp_peer_address = "100.100.0.13/30"
    bgp_address      = "100.100.0.14/30"
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

##
# Route53 Root Domain
##

root_domains = {
  "test-and-trace.nhs.uk" = {
    ses_enable = false
    primary    = true

    records = [
      {
        name = "test-and-trace.nhs.uk."
        type = "MX"
        ttl  = 300

        records = [
          "0 testandtrace-nhs-uk01bb.mail.protection.outlook.com",
        ]
      },
      {
        name = "test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "miro-verification=c66d23cd55078e170df8419dd6db07cc526d7a21",
          "MS=ms31501507",
          "v=spf1  ip4:213.121.182.84/28 ip4:194.74.226.164/28 include:spf.protection.outlook.com -all",
          "atlassian-domain-verification=HbGBqC3AYmI9Hq2v4UOCwPjLk0GLCLEnvj2q8KaRNZZkOSevQZQ1OfvajF07hicC",
          "google-site-verification=e0UiTNXVGkI3UB7w_CO2xbWpvzBvBIqECA3dF6k2JAU",
          "Dynatrace-site-verification=e94a1729-c44d-4509-8c32-417104d441cb__ek5np2khdb1bonq4eet547sngn",
          "cloudhealth=88550ae5-940b-4707-a5cb-2a13b8cea696",
        ]
      },
      {
        name = "autodiscover.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "autodiscover.outlook.com.",
        ]
      },
      {
        name = "_pki-validation.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "FF6E-0394-C709-70F4-4943-D750-A774-D279",
        ]
      },
      {
        name = "_dmarc.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "v=DMARC1; p=quarantine; pct=100; rua=mailto:dmarc-rua@dmarc.service.gov.uk; ruf=mailto:Security@ukhsa.gov.uk; fo=1",
        ]
      },
      {
        name = "selector1._domainkey.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "selector1-testandtrace-nhs-uk01bb._domainkey.nihptestandtrace.onmicrosoft.com.",
        ]
      },
      {
        name = "selector2._domainkey.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "selector2-testandtrace-nhs-uk01bb._domainkey.nihptestandtrace.onmicrosoft.com.",
        ]
      },
      {
        name = "enquiries.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "enquiries.test-and-trace.nhs.uk.00d4k000001ns6uuae.live.siteforce.com.",
        ]
      },
      {
        name = "enquiries._domainkey.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "enquiries.n0h7p5.custdkim.salesforce.com.",
        ]
      },
      {
        name = "enquiries-alt._domainkey.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "enquiries-alt.92bjru.custdkim.salesforce.com.",
        ]
      },
      {
        name = "email.enquiries.test-and-trace.nhs.uk."
        type = "MX"
        ttl  = 3600

        records = [
          "0 email-enquiries-testandtrace-nhs-uk05bb.mail.protection.outlook.com.",
        ]
      },
      {
        name = "autodiscover.email.enquiries.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "autodiscover.outlook.com.",
        ]
      },
      {
        name = "email.enquiries.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "MS=ms99010382",
          "v=spf1 mx include:_spf.salesforce.com include:spf.protection.outlook.com -all",
        ]
      },
      {
        name = "selector1._domainkey.email.enquiries.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "selector1-email-enquiries-testandtrace-nhs-uk05bb._domainkey.nihptestandtrace.onmicrosoft.com.",
        ]
      },
      {
        name = "selector2._domainkey.email.enquiries.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "selector2-email-enquiries-testandtrace-nhs-uk05bb._domainkey.nihptestandtrace.onmicrosoft.com.",
        ]
      },
      {
        name = "_dmarc.email.enquiries.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "v=DMARC1; p=quarantine; pct=100; rua=mailto:dmarc-rua@dmarc.service.gov.uk; ruf=mailto:halo.secops.ir@test-and-trace.nhs.uk; fo=1"
        ]
      },
      {
        name = "sfdc._domainkey.email.enquiries.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "sfdc.mphkj8.custdkim.salesforce.com.",
        ]
      },
      {
        name = "sfdcalt._domainkey.email.enquiries.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "sfdcalt.2d98ky.custdkim.salesforce.com.",
        ]
      },
      {
        name = "_github-challenge-dhsc.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 30

        records = [
          "679b3ce4ab",
        ]
      },
      {
        name = "_github-challenge-test-and-trace.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 30

        records = [
          "6f07b56936",
        ]
      },
      {
        name = "hub.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 30

        records = [
          "d2pgy5h5h0yzap.cloudfront.net.",
        ]
      },
      {
        name = "_787a1618d567d8b48eea3edc48012728.hub.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 30

        records = [
          "_26727b027607df0db1d0cb73a4690d0b.qqqfmgwtgn.acm-validations.aws.",
        ]
      },
      {
        name = "folk.test-and-trace.nhs.uk."
        type = "MX"
        ttl  = 300

        records = [
          "0 folk-testandtrace-nhs-uk02cc.mail.protection.outlook.com.",
        ]
      },
      {
        name = "autodiscover.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "autodiscover.outlook.com.",
        ]
      },
      {
        name = "folk.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "v=spf1 mx include:_spf.salesforce.com include:spf.protection.outlook.com -all",
        ]
      },
      {
        name = "folk.prod1._domainkey.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "folk.prod1.9oldb3.custdkim.salesforce.com.",
        ]
      },
      {
        name = "folk.prod2._domainkey.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "folk.prod2.fgd1qu.custdkim.salesforce.com.",
        ]
      },
      {
        name = "folk.uat1._domainkey.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "folk.uat1.t7tlsh.custdkim.salesforce.com.",
        ]
      },
      {
        name = "folk.uat2._domainkey.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "folk.uat2.ll694e.custdkim.salesforce.com.",
        ]
      },
      {
        name = "folk.qa1._domainkey.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "folk.qa1.cl0gv0.custdkim.salesforce.com.",
        ]
      },
      {
        name = "folk.qa2._domainkey.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "folk.qa2.e9tp91.custdkim.salesforce.com.",
        ]
      },
      {
        name = "folk.dev1._domainkey.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "folk.dev1.ah9w91.custdkim.salesforce.com.",
        ]
      },
      {
        name = "folk.dev2._domainkey.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "folk.dev2.5udw6t.custdkim.salesforce.com.",
        ]
      },
      {
        name = "_dmarc.folk.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "v=DMARC1; p=quarantine; pct=100; rua=mailto:dmarc-rua@dmarc.service.gov.uk; ruf=mailto:halo.secops.ir@test-and-trace.nhs.uk; fo=1",
        ]
      },
      {
        name = "email.survey.test-and-trace.nhs.uk."
        type = "MX"
        ttl  = 3600

        records = [
          "0 testandtrace-nhs-uk01bb.mail.protection.outlook.com",
        ]
      },
      {
        name = "qualtrics._domainkey.email.survey.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 300

        records = [
          "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCG+zU+cAPZaV/gWC89Z8aj+EELOt9SZwKP3BzFD7mjbiZFvednx5NPHkMq7OTlANBpH1ljazqI5pltVnPUhfhtWuFHYddxLml+YfZiqBzSoA7zZjELJB1xFHrx+4+2gddW0WQ4pd53JMQ+b8lnfK0OslepZSD1wAR/UDWNq9uhNQIDAQAB"
        ]
      },
      {
        name = "survey.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 300

        records = [
          "testandtrace.vanity7.eu.qualtrics.com.",
        ]
      },
      {
        name = "education.test-and-trace.nhs.uk."
        type = "MX"
        ttl  = 3600

        records = [
          "0 education-testandtrace-nhs-uk03ee.mail.protection.outlook.com.",
        ]
      },
      {
        name = "autodiscover.education.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "autodiscover.outlook.com.",
        ]
      },
      {
        name = "education.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "v=spf1 a:dispatch-eu.ppe-hosted.com ip4:54.229.2.165 ip4:52.30.130.201 include:spf.protection.outlook.com -all",
        ]
      },
      {
        name = "_dmarc.education.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "v=DMARC1; p=quarantine; pct=100; rua=mailto:dmarc-rua@dmarc.service.gov.uk; ruf=mailto:halo.secops.ir@test-and-trace.nhs.uk; fo=1",
        ]
      },
      {
        name = "selector1._domainkey.education.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "selector1-education-testandtrace-nhs-uk03ee._domainkey.nihptestandtrace.onmicrosoft.com.",
        ]
      },
      {
        name = "selector2._domainkey.education.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "selector2-education-testandtrace-nhs-uk03ee._domainkey.nihptestandtrace.onmicrosoft.com.",
        ]
      },
      {
        name = "contact-tracing.test-and-trace.nhs.uk."
        type = "NS"
        ttl  = 3600

        records = [
          "ns-7.awsdns-00.com.",
          "ns-819.awsdns-38.net.",
          "ns-1249.awsdns-28.org.",
          "ns-2030.awsdns-61.co.uk.",
        ]
      },
      {
        name = "amberarrivals.test-and-trace.nhs.uk."
        type = "NS"
        ttl  = 3600

        records = [
          "ns1-09.azure-dns.com.",
          "ns2-09.azure-dns.net.",
          "ns3-09.azure-dns.org.",
          "ns4-09.azure-dns.info.",
        ]
      },
      {
        name = "scepnp.test-and-trace.nhs.uk."
        type = "A"
        ttl  = 300

        records = [
          "20.90.168.174",
        ]
      },
      {
        name = "sceppr.test-and-trace.nhs.uk."
        type = "A"
        ttl  = 300

        records = [
          "20.90.123.237",
        ]
      },
      {
        name = "demandtest.test-and-trace.nhs.uk."
        type = "MX"
        ttl  = 3600

        records = [
          "0 demandtest-testandtrace-nhs-uk03ee.mail.protection.outlook.com.",
        ]
      },
      {
        name = "autodiscover.demandtest.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "autodiscover.outlook.com.",
        ]
      },
      {
        name = "demandtest.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "v=spf1 a:dispatch-eu.ppe-hosted.com ip4:54.229.2.165 ip4:52.30.130.201 include:spf.protection.outlook.com -all",
        ]
      },
      {
        name = "_dmarc.demandtest.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "v=DMARC1; p=quarantine; pct=100; rua=mailto:dmarc-rua@dmarc.service.gov.uk; ruf=mailto:halo.secops.ir@test-and-trace.nhs.uk; fo=1",
        ]
      },
      {
        name = "selector1._domainkey.demandtest.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "selector1-demandtest-testandtrace-nhs-uk03ii._domainkey.nihptestandtrace.onmicrosoft.com.",
        ]
      },
      {
        name = "selector2._domainkey.demandtest.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "selector2-demandtest-testandtrace-nhs-uk03ii._domainkey.nihptestandtrace.onmicrosoft.com.",
        ]
      },
      {
        name = "selector1._domainkey.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "selector1-folk-testandtrace-nhs-uk02cc._domainkey.nihptestandtrace.onmicrosoft.com.",
        ]
      },
      {
        name = "selector2._domainkey.folk.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "selector2-folk-testandtrace-nhs-uk02cc._domainkey.nihptestandtrace.onmicrosoft.com.",
        ]
      },
      {
        name = "selector1._domainkey.demand.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "selector1-demand-testandtrace-nhs-uk02ii._domainkey.nihptestandtrace.onmicrosoft.com."
        ]
      },
      {
        name = "selector2._domainkey.demand.test-and-trace.nhs.uk."
        type = "CNAME"
        ttl  = 3600

        records = [
          "selector2-demand-testandtrace-nhs-uk02ii._domainkey.nihptestandtrace.onmicrosoft.com."
        ]
      },
      {
        name = "_github-challenge-ukhsa-collaboration-org.test-and-trace.nhs.uk."
        type = "TXT"
        ttl  = 30

        records = [
          "7d3c3f4eec",
        ]
      },
      {
        name = "dev.azure.test-and-trace.nhs.uk."
        type = "NS"
        ttl  = 3600

        records = [
          "ns1-03.azure-dns.com.",
          "ns2-03.azure-dns.net.",
          "ns3-03.azure-dns.org.",
          "ns4-03.azure-dns.info.",
        ]
      },
      {
        name = "prod.azure.test-and-trace.nhs.uk."
        type = "NS"
        ttl  = 3600

        records = [
          "ns1-07.azure-dns.com.",
          "ns2-07.azure-dns.net.",
          "ns3-07.azure-dns.org.",
          "ns4-07.azure-dns.info.",
        ]
      },
    ]
  }

  "nihp.nhs.uk" = {
    ses_enable = false
    primary    = false

    records = [
      {
        name    = "autodiscover.nihp.nhs.uk."
        type    = "CNAME"
        ttl     = 300
        records = ["autodiscover.outlook.com."]
      },
      {
        name    = "nihp.nhs.uk."
        type    = "MX"
        ttl     = 300
        records = ["0 nihp-nhs-uk.mail.protection.outlook.com"]
      },
      {
        name = "nihp.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "miro-verification=c66d23cd55078e170df8419dd6db07cc526d7a21",
          "MS=ms98403895",
          "v=spf1 include:spf.protection.outlook.com -all",
          "atlassian-domain-verification=HbGBqC3AYmI9Hq2v4UOCwPjLk0GLCLEnvj2q8KaRNZZkOSevQZQ1OfvajF07hicC",
          "Dynatrace-site-verification=ee1560d2-9d0a-4433-a02d-d0f8dfb7eb1f__aitr4gu6eqovhp1m0devgfa17b",
          "cloudhealth=11c7af56-3fcd-4064-ab5c-fdc0b78e1922",
        ]
      },
      {
        name = "_pki-validation.nihp.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "5AFD-324E-5E75-CABD-C3B0-28DE-2264-A7CD",
        ]
      },
      {
        name = "_dmarc.nihp.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "v=DMARC1; p=quarantine; pct=100; rua=mailto:dmarc-rua@dmarc.service.gov.uk; ruf=mailto:halo.secops.ir@test-and-trace.nhs.uk; fo=1",
        ]
      },
      {
        name    = "selector1._domainkey.nihp.nhs.uk."
        type    = "CNAME"
        ttl     = 300
        records = ["selector1-nihp-nhs-uk._domainkey.nihptestandtrace.onmicrosoft.com."]
      },
      {
        name    = "selector2._domainkey.nihp.nhs.uk."
        type    = "CNAME"
        ttl     = 300
        records = ["selector2-nihp-nhs-uk._domainkey.nihptestandtrace.onmicrosoft.com."]
      },
      {
        name    = "sip.nihp.nhs.uk."
        type    = "CNAME"
        ttl     = 3600
        records = ["sipdir.online.lync.com."]
      },
      {
        name    = "lyncdiscover.nihp.nhs.uk."
        type    = "CNAME"
        ttl     = 3600
        records = ["webdir.online.lync.com."]
      },
      {
        name    = "_sipfederationtls._tcp.nihp.nhs.uk."
        type    = "SRV"
        ttl     = 3600
        records = ["1 100 5061 sipfed.online.lync.com."]
      },
      {
        name    = "_sip._tls.nihp.nhs.uk."
        type    = "SRV"
        ttl     = 3600
        records = ["1 100 443 sipfed.online.lync.com."]
      },
    ]
  }

  "covid.nhs.uk" = {
    ses_enable = false
    primary    = false

    records = [
      {
        name    = "tracing.covid.nhs.uk."
        type    = "CNAME"
        ttl     = 300
        records = ["tracing.covid.nhs.uk.00D4K000001nS6uUAE.live.siteforce.com."]
      },
      {
        name = "_pki-validation.covid.nhs.uk."
        type = "TXT"
        ttl  = 3600

        records = [
          "5AFD-324E-5E75-CABD-C3B0-28DE-2264-A7CD",
        ]
      },
    ]
  }
}

###
# Logging
###

cloudwatch_logs_notification_prefixes = [
  "apigateway",
  "transfer",
  "workspaces-audit",
  "workspaces-login",
  "workspaces-secure",
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
  branch                        = "main"
  deploy_key_ssm_parameter_name = "LandingZoneGitHubRSA"
}

lzp_chatbot = {
  enable             = true
  slack_channel_id   = "C01J4HH2RCM"
  slack_workspace_id = "T019X3MSH9Q"
}

lzp_docker_image = {
  name    = "run/terraform"
  version = "1.0.0"
}

lzp_sfn_concurrency = 40
lzp_sfn_schedule    = "cron(0 11 * * ? *)"

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
  slack_channel_id   = "C05EFGJ634N" # #aws-builds-pr channel
  slack_workspace_id = "T019X3MSH9Q"
}

lzp_github_notifications_chatbot = {
  enable             = true
  slack_channel_id   = "C05B3Q51XE1" # #halo-hosting-aws-prod-deployments channel
  slack_workspace_id = "T019X3MSH9Q"
}

tfr_modules_docker_image = {
  name    = "run/terraform"
  version = "1.0.0"
}

tfr_modules_github = {
  organization                  = "test-and-trace"
  repo_name                     = "halo-terraform-modules"
  branch                        = "main"
  deploy_key_ssm_parameter_name = "LandingZoneGitHubRSA"
}

tfr_modules_subnets = {
  count       = 3
  newbits     = 12
  netnum_root = 4054
}

tfr_api_users = {
  cc       = {}
  genomics = {}
  init     = {}
  mdsk     = {}
  qms      = {}
}

##
# SSO
##

# SSO additional roles
sso_assumable_roles = {
  "AccountDeploymentUser"        = {}
  "AdvancedAnalyst"              = {}
  "AdvancedApplicationDeveloper" = {}
  "Analytics"                    = { ReadOnlyAttachment = false }
  "ApplicationDeploymentUser"    = {}
  "ApplicationDeveloper"         = {}
  "ApplicationSupport"           = {}
  "ApplicationTester"            = {}
  "ApplicationUser"              = {}
  "Auditor"                      = {}
  "CyberOps"                     = {}
  "DataAnalyst"                  = { ReadOnlyAttachment = false }
  "DatabaseAdministrator"        = {}
  "DataEngineer"                 = {}
  "DataEngineerGPHA"             = {}
  "DataEngineeringSupport"       = {}
  "DataOperations"               = {}
  "DataQualityEngineer"          = { ReadOnlyAttachment = false }
  "DataReader"                   = {}
  "DataRetentionHome"            = {}
  "DataRetentionIanto"           = {}
  "DataRetentionLFT"             = {}
  "DataRetentionResults"         = {}
  "DataRetentionRMS"             = {}
  "DataScientist"                = { ReadOnlyAttachment = false }
  "DataScientistCIAB"            = { ReadOnlyAttachment = false }
  "DataScientistDaSH"            = { ReadOnlyAttachment = false }
  "DataScientistGPHA"            = { ReadOnlyAttachment = false }
  "DataScientistHEP"             = { ReadOnlyAttachment = false }
  "DataScientistTM"              = { ReadOnlyAttachment = false }
  "DataScientistWS"              = { ReadOnlyAttachment = false }
  "Developer"                    = {}
  "FileUploader"                 = {}
  "HomtstAlArm1"                 = { ReadOnlyAttachment = false }
  "HomtstAlArm2"                 = { ReadOnlyAttachment = false }
  "HomtstLabOnboarding"          = { ReadOnlyAttachment = false }
  "HomtstLftAdministrators"      = { ReadOnlyAttachment = false }
  "HomtstOutbreakControl"        = { ReadOnlyAttachment = false }
  "MigrationQA"                  = {}
  "NonPiiReadOnly"               = { ReadOnlyAttachment = false }
  "Operations"                   = {}
  "PlatformEngineer"             = {}
  "PlatformUser"                 = { ReadOnlyAttachment = false }
  "QATUser"                      = {}
  "QuickSightAuthor"             = {}
  "QuickSightReader"             = {}
  "ReportViewer"                 = {}
  "Tester"                       = {}
}

# SSO mapping/s for *audit* account only
audit_sso_associations = {
  "Grp.Aws.Console.LandingZone.Production.Audit.ReadOnly" = ["ReadOnly"]
}

# NOTE: The Opsgenie endpoints are different depending on the integration
# target, so this is specifically for SNS based alerts...
primary_alerts_opsgenie_sns = {
  enable               = true
  endpoint_critical    = "https://api.eu.opsgenie.com/v1/json/amazonsns?apiKey=4f08043d-a939-4a01-9b55-25617f38c6e6"
  endpoint_noncritical = "https://api.eu.opsgenie.com/v1/json/amazonsns?apiKey=32a28669-9a07-4388-90c9-a4d7e361c64a"
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

# effectively "10.0.0.0/9", but "10.0.0.0/24" historically not used
ipam_available_cidr_ranges = {
  main = [
    "10.1.0.0/16",
    "10.2.0.0/15",
    "10.4.0.0/14",
    "10.8.0.0/13",
    "10.16.0.0/12",
    "10.32.0.0/11",
    "10.64.0.0/10",
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
    alert_priority = "P3"

    # Automatic Integration
    team_name = "UKHSA Cloud Platform - AWS"

    # Manual Integrations
    api_keys = []
  }
}

##
# Noti - Notification Scheduler
##

notification_schedules = {
  managed-desktops-api-user     = { deadline = "2024-10-16", title = "Renew Managed Desktops API User", description = "Renew password for Managed Desktop API user (userid.api) on the Palo Alto Firewalls - password stored in Systems Manager in MDSK accounts" },
  managed-desktops-jira-api-key = { deadline = "2024-06-02", title = "Renew Jira API key for in Prod", description = "Renew Jira API key for svc_AwsHosting service account in production Jira environment and update ssm param in MDSK Tooling account." },
  pr-identity-centre-scim       = { deadline = "2024-11-15", title = "Renew Identity Centre SCIM access token in PR", description = "Renew SCIM access token in PR - HAH-5949" },
  pr-managed-desktops-saml      = { deadline = "2026-11-27", title = "Renew SAML Certificate in Managed Desktops Test", description = "Renew the SAML Signing Certificate for the Managed Desktops Test Enterprise Application in Azure, and update it in the MDSK Prod2 AWS account" },
  pr-contact-centre-saml        = { deadline = "2026-11-28", title = "Renew SAML Certificate in Contact Centre Prod", description = "Renew the SAML Signing Certificate for the Contact Centre Prod Enterprise Application in Azure, and update it in the CC Prod2 AWS account" },
}


##
# EC2 Usage Report
##

ec2_usage_report_email_subscriptions = [
  "frankie.rudd@ukhsa.gov.uk",
  "Sara.Bottom@ukhsa.gov.uk",
  "Ollie.Subramanian@ukhsa.gov.uk",
]


##
# CLoudOps Email Subscriptions
# To receive Alarms originally sent to Opsgenie
##
email_subscriptions = [
  "UCPCloudOps-AWS@ukhsa.gov.uk"
]


