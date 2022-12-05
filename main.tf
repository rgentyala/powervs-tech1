resource "ibm_pi_ike_policy" "ikepol7" {    
  pi_cloud_instance_id    = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
  pi_policy_name          = "ikepol7"    
  pi_policy_dh_group = 20   
  pi_policy_encryption = "aes-256-cbc"  
  pi_policy_key_lifetime = 28800    
  pi_policy_preshared_key = "falabella"    
  pi_policy_version = 2     
  pi_policy_authentication = "sha-256"
}  

resource "ibm_pi_ipsec_policy" "ipsecpol7" {
  pi_cloud_instance_id    = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
  pi_policy_name          = "ipsecpol7"
  pi_policy_dh_group = 20
  pi_policy_encryption = "aes-256-cbc"
  pi_policy_key_lifetime = 28800
  pi_policy_pfs = true
  pi_policy_authentication = "hmac-sha-256-128"
}

data "ibm_pi_network" "network2" {
  pi_network_name = "testvpn"
  pi_cloud_instance_id = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
}

resource "ibm_pi_vpn_connection" "vpndfd2" {
  pi_cloud_instance_id    = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"  
  pi_vpn_connection_name  = "vpndfd2"
  pi_ike_policy_id        = ibm_pi_ike_policy.ikepol7.policy_id
  pi_ipsec_policy_id      = ibm_pi_ipsec_policy.ipsecpol7.policy_id
  pi_vpn_connection_mode  = "route"
  pi_networks             = [data.ibm_pi_network.network2.id]
  pi_peer_gateway_address = "169.46.19.238"
  pi_peer_subnets         = ["10.177.131.192/26"]
}

