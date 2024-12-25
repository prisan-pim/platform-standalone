variable "private_dns_zone" {
  type = list(string)
  default = []
}

variable "cloudflare_zone" {
  default = ""
}

variable "name" {
  default = ""
}