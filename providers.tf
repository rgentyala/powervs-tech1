variable "ibmcloud_api_key" {
  description = "Enter your IBM Cloud API Key, you can get your IBM Cloud API key using: https://cloud.ibm.com/iam#/apikeys"
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
  zone             = var.zone
}

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}

locals {
  pvs_info          = split(":", var.crn)
  location          = local.pvs_info[5]
  region            = can(regex("-", local.location)) ? (can(regex("-[0-9]+$", local.location)) ? replace(local.location, regex("-[0-9]+$", local.location), "") : local.location) : (can(regex("[0-9]+$", local.location)) ? replace(local.location, regex("[0-9]+$", local.location), "") : local.location)
  cloud_instance_id = local.pvs_info[7]
}
