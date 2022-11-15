variable "key_name" {
  description = "Value of AWS Region"
  type        = string
}

variable "security_group_ids" {
  description = "IDs of Security Group for bastion host"
  type        = list
}

variable "public_subnet_id" {
  description = "Public Subnet ID for Bastion host"
  type        = string
}

variable "pem_location" {
  description = "Location for Pem Key File"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "m5.4xlarge"
}

variable "volume_size" {
  description = "EC2 Instance Type"
  type        = number
  default     = 1023
}

variable "ami" {
  description = "Specific AMI image"
  type        = string
  default     = ""
}

variable "os" {
  description = "Specific Operating System"
  type        = string
  default     = "ubuntu"
}

variable "license_sig_location" {
  description = "location of license.sig in the terraform folder"
  type        = string
  default     = "templates/license.sig"
}
