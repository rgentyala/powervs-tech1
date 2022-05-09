data "ibm_pi_image" "ds_image" {
  pi_image_name        = var.image
  pi_cloud_instance_id = local.pid
}

data "ibm_pi_network" "power_network" {
  pi_cloud_instance_id = local.pid
  pi_network_name      = var.network_name
}

data "ibm_pi_storage_type_capacity" "type" {
  pi_cloud_instance_id = local.pid
  pi_storage_type = "Tier3-Flash-1"
}

resource "ibm_pi_instance" "instance" {
  pi_cloud_instance_id = local.pid
  pi_memory            = var.memory
  pi_processors        = var.processors
  pi_instance_name     = var.instance_name
  pi_proc_type         = var.processor_type
  pi_image_id          = data.ibm_pi_image.ds_image.id
  pi_sys_type          = "tier3"
  pi_storage_type      = data.ibm_pi_storage_type_capacity.type.pi_storage_type
  pi_network {
    network_id = data.ibm_pi_network.power_network.id
  }
}
