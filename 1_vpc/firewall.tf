# Firewall Rules for VPC 1

resource "google_compute_firewall" "firewall_vpc1" {
  name    = "${var.vpc_1}-firewall"
  network = google_compute_network.vpc_1.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "${google_compute_subnetwork.subnet1_vpc1.ip_cidr_range}" , 
    "${google_compute_subnetwork.subnet_a_vpc2.ip_cidr_range}" , 
    "${google_compute_subnetwork.subnet_a_vpc3.ip_cidr_range}" , 
    "0.0.0.0/0"
  ]
}


# Firewall Rules for VPC 2
resource "google_compute_firewall" "firewall_vpc2" {
  name    = "${var.vpc_2}-firewall"
  network = google_compute_network.vpc_2.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "${google_compute_subnetwork.subnet1_vpc1.ip_cidr_range}" , 
    "${google_compute_subnetwork.subnet_a_vpc2.ip_cidr_range}" , 
    "${google_compute_subnetwork.subnet_a_vpc3.ip_cidr_range}" , 
  ]
}

# Firewall Rules for VPC 3
resource "google_compute_firewall" "firewall_vpc3" {
  name    = "${var.vpc_3}-firewall"
  network = google_compute_network.vpc_3.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "${google_compute_subnetwork.subnet1_vpc1.ip_cidr_range}" , 
    "${google_compute_subnetwork.subnet_a_vpc2.ip_cidr_range}" , 
    "${google_compute_subnetwork.subnet_a_vpc3.ip_cidr_range}" , 
  ]
}
