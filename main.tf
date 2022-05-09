data "ibm_pi_image" "ds_image" {
  pi_image_name        = var.image
  pi_cloud_instance_id = local.pid
}
locals {
  public_image_name = "7200-05-01"
  catalog_image = [for x in data.ibm_pi_catalog_images.catalog_images.images : x if x.name == local.public_image_name]
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
  pi_image_id          = data.ibm_pi_image.ds_image.id
  pi_sys_type          = var.sys_type
  pi_storage_type          = "tier3"
  pi_network {
    network_id = data.ibm_pi_network.power_network.id
  }
}
