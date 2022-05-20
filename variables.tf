variable "region" {
  default = "lon"
}

variable "zone" {
  default = "lon04"
}

variable "imagename" {
  description = "Name of the image to be used"
  default     = "paytester_v1"
}

variable "powerinstanceid" {
  description = "Power Instance associated with the account"
}

variable "instancename" {
  default     = "pt_instance"
  description = "Name of the instance"
}

variable "sshkeyname" {
  default     = "mykey"
  description = "Name of the ssh key to be used"
}

variable "volname" {
  default     = "myvol"
  description = "Name of the volume"
}

variable "networkname" {
  default     = "mypublicnw"
  description = "Name of the network"
}
