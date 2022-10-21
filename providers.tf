terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}

locals {
  cloud_instance_id = local.pvs_info[7]
}
