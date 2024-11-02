
output "vpc-internal" {
  value = google_compute_network.vpc_1.name
}

output "subnet_internal" {
  value = {
    subnet_1 = google_compute_subnetwork.subnet1_vpc1.name
  }
}

output "vpc-dev" {
  value = google_compute_network.vpc_2.name
}

output "subnet_dev" {
  value = {
    subnet_1 = google_compute_subnetwork.subnet_a_vpc2.name
  }
}

output "vpc-prod" {
  value = google_compute_network.vpc_3.name
}

output "subnet_prod" {
  value = {
    subnet_1 = google_compute_subnetwork.subnet_a_vpc3.name
  }
}

output "firewall" {
  value = {
    vpc1 = google_compute_firewall.firewall_vpc1.name
    vpc2 = google_compute_firewall.firewall_vpc2.name
    vpc3 = google_compute_firewall.firewall_vpc3.name
  }
}
