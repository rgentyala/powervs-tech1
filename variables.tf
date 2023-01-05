variable "ibm_cloud_api_key" {
  type        = string
  description = "API Key for clip account for user#1"
}

variable "image_name" {
  description = "Name of the image to be deployed"
  default     = "cliptestimage"
}

variable "crn" {
  type        = string
  default     = "crn:v1:bluemix:public:power-iaas:us-west:a/<name1>:<name2>::"
  description = "Power Systems Virtual Server CRN reference"
}

variable "instancename" {
  default     = "newpowervs"
  description = "Name of the instance to be created"
}
