data "ibm_pi_key" "ds_instance" {
  pi_key_name          = "ssh-poc"
  pi_cloud_instance_id = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
}

resource "ibm_pi_network" "power_networks" {
  count                = 1
  pi_network_name      = var.networkname
  pi_cloud_instance_id = var.powerinstanceid
  pi_network_type      = "pub-vlan"
}

data "ibm_pi_public_network" "dsnetwork" {
  depends_on           = [ibm_pi_network.power_networks]
  pi_cloud_instance_id = var.powerinstanceid
}

data "ibm_pi_network" "ds_network" {
  pi_network_name = "APP"
  pi_cloud_instance_id = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
}



data "ibm_pi_image" "powerimages" {
  pi_image_name        = var.imagename
  pi_cloud_instance_id = var.powerinstanceid
}

resource "ibm_pi_instance" "test-instance" {
  pi_memory            = "5"
  pi_processors        = "0.25"
  pi_instance_name     = var.instancename
  pi_proc_type         = "shared"
  pi_image_id          = var.ibm_pi_image.powerimages.id
  pi_key_pair_name     = var.ibm_pi_key.dskey.id
  pi_sys_type          = "s922"
  pi_cloud_instance_id = var.powerinstanceid
  pi_storage_type      = "tier3"

  pi_network {
    network_id = data.ibm_pi_public_network.dsnetwork.id
  }
}
