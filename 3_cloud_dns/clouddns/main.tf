# Google DNS Managed Zone (Private)

# resource "google_dns_managed_zone" "public_dns_zone" {
#   name        = "public-${var.google_dns_zone_name}"
#   dns_name    = var.google_dns_dns_name
#   description = var.google_dns_description

#   visibility = "public"
# }

resource "google_dns_managed_zone" "private_dns_zone" {
  name        = "private-${var.google_dns_zone_name}"
  dns_name    = var.google_dns_dns_name
  description = var.google_dns_description

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = "projects/${var.project}/global/networks/${var.network_nonprd}"
    }
    networks {
      network_url = "projects/${var.project}/global/networks/${var.network_internal}"
    }
  }
}

resource "google_dns_record_set" "internal_nginx" {
  name = "*.${google_dns_managed_zone.private_dns_zone.dns_name}"
  type = "A"
  ttl  = 300
 
  managed_zone = google_dns_managed_zone.private_dns_zone.name
  rrdatas = var.ip_ingree
}

