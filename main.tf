data "ibm_pi_image" "ds_image" {
  pi_image_name        = "IBMi-74-05-2984-1"
  pi_cloud_instance_id = local.pid
}

data "ibm_pi_key" "key" {
  pi_cloud_instance_id = local.pid
  pi_key_name          = var.ssh_key_name
}

data "ibm_pi_network" "power_network" {
  pi_cloud_instance_id = local.pid
  pi_network_name      = var.network_name
}

resource "ibm_pi_instance" "instance" {
  pi_cloud_instance_id = local.pid
  pi_memory            = var.memory
  pi_processors        = var.processors
  pi_instance_name     = var.instance_name
  pi_proc_type         = var.processor_type
  pi_image_id          = local.catalog_image[0].image_id
  pi_key_pair_name     = data.ibm_pi_key.key.id
  pi_sys_type          = var.sys_type
  pi_storage_type = var.storage_tier
  pi_network {
    network_id = data.ibm_pi_network.power_network.id
  }
}
