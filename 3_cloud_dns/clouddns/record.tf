# resource "google_dns_record_set" "frontend" {
#   name = "*.${google_dns_managed_zone.private_dns_zone.dns_name}"
#   type = "A"
#   ttl  = 300
 
#   managed_zone = google_dns_managed_zone.private_dns_zone.name
#   rrdatas = [var.ip_ingree]
# }