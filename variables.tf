/*===================================================================================
Author: Vern Bolinius
Date: 2021 02 01
Revision: 1.0
Description:
This is the variable definition file for code that sets up a test SDDC
in the AWS London region that I find useful.  This associated code creates:
SDDC:
 - An SDDC in the AWS London region

NOTE: By convention, I preface the names of all SDDC constructs with my initals - "VB"
====================================================================================*/

/* API token generated in Cloud Console for Org VMC-SET-TEST for boliniusv@vmware.com
with roles of Org Owner + SDDC Administrator + NSX Administrator */
variable "api_token" {
  description = "API token used to authenticate when calling the VMware Cloud Services API."
}


/* Organization ID for the Org containing the VMC-SET-TEST SDDC */
variable "org_id" {
  description = "Organization Identifier."
}


/* AWS Account for EMEA SET team */
variable "aws_account_number" {
  description = "The AWS account number."
}


variable "sddc_name" {
  description = "Name of SDDC."
  default     = "VB-SDDC1"
}


/* Build the test SDDC in the London region */
variable "sddc_region" {
  description = "The AWS region."
  default     = "EU_WEST_2"
}


/* Use the CIDR for VB-VPC-SIDECAR, created using a separate Terraform script */
variable "vpc_cidr" {
  description = "AWS VPC IP range. Only prefix of 16 or 20 is currently supported."
  default     = "10.2.0.0/16"
}


variable "vxlan_subnet" {
  description = "VXLAN IP subnet in CIDR for compute gateway."
  default     = "192.168.1.0/24"
}
