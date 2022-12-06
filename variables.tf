variable "api_key" {
  type        = string
  description = "API Key"
}

variable "image_name" {
  description = "Name of the image to be used"
  default     = "clai-pivote"
}

variable "crn" {
  type        = string
  default     = "crn:v1:bluemix:public:power-iaas:us-south:a/8fa8c2d1e1d943ad862c1e1d0860ed79:42175bd4-dc42-4ce0-ac6f-bc55caac4b7c::"
  description = "Power Systems Virtual Server CRN"
}

variable "instancename" {
  default     = "newvsi"
  description = "Name of the instance"
}
