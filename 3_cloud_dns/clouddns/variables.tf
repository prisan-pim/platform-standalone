
variable "project" {
  type        = string
  description = "The ID of the project in which to create the DNS zone."
}

variable "region" {
  type        = string
  description = "The Google Cloud region to use."
}

variable "google_dns_zone_name" {
  type        = string
  description = "The name of the Google DNS managed zone."
}

variable "google_dns_dns_name" {
  type        = string
  description = "The DNS name for the Google DNS zone."
}

variable "google_dns_description" {
  type        = string
  description = "A description of the Google DNS managed zone."
}

variable "network_nonprd" {
  type        = string
  description = "The network URL to associate with the private DNS zone."
}

variable "cloudflare_api_token" {
  type        = string
  description = "The API token to manage Cloudflare DNS."
}

variable "cloudflare_zone" {
  type        = string
  description = "The Cloudflare zone ID where the NS record should be created."
}

variable "cloudflare_record_name" {
  type        = string
  description = "The name of the Cloudflare DNS record to create."
}

variable "ip_ingree" {
  type = list(string)
  default = []
}

variable "network_internal" {
  default = ""
}

variable "network_prd" {
  default = ""
}