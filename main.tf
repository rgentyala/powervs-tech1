data "ibm_pi_key" "ds_instance" {
  pi_key_name          = "ssh-poc"
  pi_cloud_instance_id = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
}

data "ibm_pi_network" "power_network" {
  pi_network_name = "sn-cripto-aas"
  pi_cloud_instance_id = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
}

data "ibm_pi_image" "powerimages" {
  pi_image_name        = var.imagename
  pi_cloud_instance_id = var.powerinstanceid
}

resource "ibm_pi_instance" "test-instance" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_memory            = "5"
  pi_processors        = "0.25"
  pi_instance_name     = var.instancename
  pi_proc_type         = "shared"
  pi_image_id          = var.ibm_pi_image.powerimages.id
  pi_key_pair_name     = local.ibm_pi_key.key.id
  pi_sys_type          = "s922"
  pi_storage_type      = "tier3"

  pi_network {
    network_id = data.ibm_pi_network.network.id
  }
}
