variable "region" {
  default = "asia-southeast1"
}

variable "project" {
  default =  ""
}

variable "network_nonprd" {
  default = "internal"
}


variable "network_internal" {
  default = "internal"
}

variable "network_prd" {
  default = ""
}

variable "ip_ingree" {
  type = list(string)
  default = []
}

variable "domain_ingree" {
  type = list(string)
  default = []
}


variable "cloudflare_api_token" {
  default = ""
  type        = string
  sensitive   = true
}

variable "cloudflare_zone" {
  default = ""
}