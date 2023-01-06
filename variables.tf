variable "ibm_cloud_api_key" {
  type        = string
  description = "API Key for clip account for user#1"
}

variable "image_name" {
  description = "Name of the image to be deployed"
  default     = "clippocimg"
}

variable "crn" {
  type        = string
  default     = "crn:v1:bluemix:public:power-iaas:us-south:a/fbd1994ed37b47e3839d109bbe7a95cd:43ddc506-12ba-4a06-882d-18bd92d0f853::"
  description = "Power Systems Virtual Server CRN reference"
}

variable "instancename" {
  default     = "newpowervs"
  description = "Name of the instance to be created"
}
