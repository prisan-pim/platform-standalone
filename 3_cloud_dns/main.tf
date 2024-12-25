provider "google" {
  project = var.project
  region  = var.region
  credentials = file("../key.json")
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

module "dns_internal_cloud_dns" {
  source = "./clouddns"

  project                  = var.project
  region                   = var.region
  google_dns_zone_name      = "dev-domain-com"
  google_dns_dns_name       = "dev.domain-com."
  google_dns_description    = "Private DNS Zone for dev.domain.com"
  network_nonprd            = var.network_nonprd
  network_internal          = var.network_internal
  network_prd               = var.network_prd
  cloudflare_api_token      = var.cloudflare_api_token
  cloudflare_zone           = var.cloudflare_zone
  ip_ingree                 = ["10.1.1.31"]
  cloudflare_record_name    = "dev.domain.com"
}
