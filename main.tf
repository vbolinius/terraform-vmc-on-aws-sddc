provider "vmc" {
  refresh_token = var.vmc_token
  org_id        = var.org_id
}

# Empty data source defined in order to store the org display name and name in terraform state
data "vmc_org" "my_org" {
}

data "vmc_connected_accounts" "my_accounts" {
  account_number = var.aws_account_number
}

data "vmc_customer_subnets" "my_subnets" {
  connected_account_id = data.vmc_connected_accounts.my_accounts.id
  region               = var.sddc_region
}

resource "vmc_sddc" "sddc_1" {
  lifecycle {
        ignore_changes = [edrs_policy_type, enable_edrs, max_hosts, min_hosts]
    }
  sddc_name           = "Vern_SDDC"
  vpc_cidr            = var.sddc_mgmt_subnet
  num_host            = 1
  provider_type       = "AWS"
  region              = data.vmc_customer_subnets.my_subnets.region
  vxlan_subnet        = var.sddc_default
  delay_account_link  = false
  skip_creating_vxlan = false
  sso_domain          = "vmc.local"
  host_instance_type  = "I3_METAL"
  sddc_type           = "1NODE"
  account_link_sddc_config {
    #customer_subnet_ids  = [data.vmc_customer_subnets.my_subnets.ids[0]]
    customer_subnet_ids = ["subnet-02c8c4f00bdefb815"]
    connected_account_id = data.vmc_connected_accounts.my_accounts.id
  }
  # sddc_template_id = ""
  deployment_type = "SingleAZ"
  timeouts {
    create = "300m"
    update = "300m"
    delete = "180m"
  }
}
