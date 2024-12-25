variable "project_name" {
  default = ""
}

variable "region" {
  default = "asia-southeast1"
}

variable "vpc" {
  default = "vpc-internal"
}

variable "subnet" {
  default = "subnet-interal-a"
}

variable "name_server" {
  default = "gitlab"
}

variable "machine_type" {
  default = "e2-standard-2"
}

variable "image" {
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "file_account" {
  default = "../../../key/ubuntu.pub"
}

variable "ip_address" {
  default = "10.0.1.15"
}