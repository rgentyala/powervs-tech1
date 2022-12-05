data "ibm_pi_key" "ssh_key" {
  pi_key_name          = "ssh-poc"
  pi_cloud_instance_id = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
}

data "ibm_pi_network" "network2" {
  pi_network_name = "testvpn"
  pi_cloud_instance_id = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
}

data "ibm_pi_image" "power_image" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_image_name        = var.image_name
}

resource "ibm_pi_ike_policy" "ikepol" {    
  pi_cloud_instance_id    = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
  pi_policy_name          = "ikepol3"    
  pi_policy_dh_group = 20   
  pi_policy_encryption = "aes-256-cbc"  
  pi_policy_key_lifetime = 28800    
  pi_policy_preshared_key = "falabella"    
  pi_policy_version = 2     
  pi_policy_authentication = "sha-256"
}  

resource "ibm_pi_ipsec_policy" "ipsecpol" {
  pi_cloud_instance_id    = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
  pi_policy_name          = "ipsecpol3"
  pi_policy_dh_group = 20
  pi_policy_encryption = "aes-256-cbc"
  pi_policy_key_lifetime = 28800
  pi_policy_pfs = true
  pi_policy_authentication = "hmac-sha-256-128"
}

resource "ibm_pi_vpn_connection" "vpndfd" {
  pi_cloud_instance_id    = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"  
  pi_vpn_connection_name  = "vpndfd2"
  pi_ike_policy_id        = "ikepol3"
  pi_ipsec_policy_id      = "ipsecpol3"
  pi_vpn_connection_mode  = "route"
  pi_networks             = ["testvpn"]
  pi_peer_gateway_address = "169.46.19.238"
  pi_peer_subnets         = ["10.177.131.192/26"]
}


resource "ibm_pi_instance" "test-instance2" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_memory            = "5"
  pi_processors        = "0.25"
  pi_instance_name     = var.instancename
  pi_proc_type         = "shared"
  pi_image_id          = data.ibm_pi_image.power_image.id
  pi_key_pair_name     = data.ibm_pi_key.ssh_key.id
  pi_sys_type          = "s922"
  pi_storage_type      = "tier3"

    pi_network {
    network_id  = data.ibm_pi_network.network2.id
  }
}

