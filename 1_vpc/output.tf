output "vpc" {
  value = {
    vpc_internal = google_compute_network.vpc_internal.name
    vpc_dev = google_compute_network.vpc_dev.name
    vpc_prod = google_compute_network.vpc_prod.name
  }
}

output "firewall" {
  value = {
    firewall_internal_ssh = google_compute_firewall.vpc_internal_ssh.name
    firewall_internal = google_compute_firewall.vpc_internal.name
    firewall_dev = google_compute_firewall.vpc_dev.name
    firewall_prod = google_compute_firewall.vpc_prod.name
  }
}