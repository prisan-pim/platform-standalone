variable "region" {
  default = "asia-southeast1"
}

variable "project" {
  default =  ""
}

variable "network" {
  default = "internal-vpc"
}

variable "subnet" {
  default = "internal-vpc-subnet-1"
}

variable "ssh_public_key_filepath" {
  default     = "../../../key-ssh/ubuntu.pub"
}

variable "project_name" {
  default = "vm-internal"
}

variable "os_config" {
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "machine_type" {
  default = "e2-small"
}

variable "internal_address" {
  default = "10.0.1.3"
}
