/*===============================================================================
Author: Vern Bolinius
Date: 2021 02 01
Revision: 1.0
Description:

This code sets up a single-node test SDDC in 
the AWS London region that I find useful.
This code creates:
SDDC:
 - A single-node SDDC in the AWS London region
================================================================================*/


/*==================================================
VMC Provider
===================================================*/

provider "vmc" {
  refresh_token	= var.api_token
  org_id = var.org_id
}


/*==================================================
SDDC Inputs
===================================================*/


data "vmc_connected_accounts" "my_accounts" {
  account_number = var.aws_account_number
}

data "vmc_customer_subnets" "my_subnets" {
  connected_account_id = data.vmc_connected_accounts.my_accounts.id
  region               = var.sddc_region
}


/*==================================================
Create the SDDC
===================================================*/

resource "vmc_sddc" "sddc_1" {
  sddc_name           = var.sddc_name
  vpc_cidr            = var.vpc_cidr
  sddc_type           = "1NODE"
  num_host            = 1
  provider_type       = "ZEROCLOUD"
  region              = data.vmc_customer_subnets.my_subnets.region
  vxlan_subnet        = var.vxlan_subnet
  delay_account_link  = false
  skip_creating_vxlan = false
  deployment_type     = "SingleAZ"
  account_link_sddc_config {
    /* customer_subnet_ids  = [data.vmc_customer_subnets.my_subnets.ids[0]] */
    /* customer_subnet_ids = ["subnet-066dcda29b0eb6335","subnet-0c7825565920691ca","subnet-039812875d5964ca9"] */
    customer_subnet_ids = ["subnet-066dcda29b0eb6335"]
    connected_account_id = data.vmc_connected_accounts.my_accounts.account_number
  }
}
