resource "ibm_pi_ike_policy" "poc_ike_policy" {
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_policy_name          = "poc-ike_policy"
        pi_policy_dh_group = 20
        pi_policy_encryption = "aes-256-cbc"
        pi_policy_key_lifetime = 28800
        pi_policy_preshared_key = "cliptech"
        pi_policy_version = 2
        pi_policy_authentication = "sha-256"
    }

resource "ibm_pi_ipsec_policy" "poc_ipsec_policy" {
        depends_on = [ibm_pi_ike_policy.poc_ike_policy]
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_policy_name          = "poc-ipsec_policy"
        pi_policy_dh_group = 20
        pi_policy_encryption = "aes-256-cbc"
        pi_policy_key_lifetime = 28800
        pi_policy_pfs = true
        pi_policy_authentication = "hmac-sha-256-128"
    }

data "ibm_pi_network" "ds_network" {
  pi_network_name = "ClipNet"
  pi_cloud_instance_id = local.cloud_instance_id
    }

resource "ibm_pi_vpn_connection" "rs_vpn_connection" {
        depends_on = [ibm_pi_ike_policy.poc_ike_policy, ibm_pi_ipsec_policy.poc_ipsec_policy]
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_vpn_connection_name  = "poc_vpn_connection"
        pi_ike_policy_id        = ibm_pi_ike_policy.poc_ike_policy.policy_id
        pi_ipsec_policy_id      = ibm_pi_ipsec_policy.poc_ipsec_policy.policy_id
        pi_vpn_connection_mode  = "route"
        pi_networks             = [data.ibm_pi_network.ds_network.id]
        pi_peer_gateway_address = "76.136.223.88"
        pi_peer_subnets         = ["192.168.0.12/24"]
    }

data "ibm_pi_key" "ssh_key" {
  pi_key_name          = "ssh-poc"
  pi_cloud_instance_id = "43ddc506-12ba-4a06-882d-18bd92d0f853"
}

data "ibm_pi_image" "power_image" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_image_name        = var.image_name
}

resource "ibm_pi_instance" "test-instance1" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_memory            = "4"
  pi_processors        = "0.25"
  pi_instance_name     = var.instancename
  pi_proc_type         = "shared"
  pi_image_id          = data.ibm_pi_image.power_image.id
  pi_key_pair_name     = data.ibm_pi_key.ssh_key.id
  pi_sys_type          = "s922"
  pi_storage_type      = "tier3"

    pi_network {
    network_id  = data.ibm_pi_network.ds_network.id
  }
}

