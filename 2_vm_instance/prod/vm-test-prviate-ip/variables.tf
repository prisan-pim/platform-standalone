variable "project_name" {
  default = ""
}

variable "region" {
  default = "asia-southeast1"
}

variable "vpc" {
  default = "vpc-dev"
}

variable "subnet" {
  default = "subnet-dev-a"
}

variable "name_server" {
  default = "vm-dev-private-ip"
}

variable "machine_type" {
  default = "e2-medium"
}

variable "image" {
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "file_account" {
  default = "../../../key/ubuntu.pub"
}