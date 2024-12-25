output "google_cloud_nameservers" {
  description = "The nameservers for the Google Cloud DNS zone."
  value       = google_dns_managed_zone.private_dns_zone.name_servers
}