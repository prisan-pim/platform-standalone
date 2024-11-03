resource "google_compute_firewall" "vpc_internal_ssh" {
  name = "${var.vpc_internal}-firewall-ssh"
  network = google_compute_network.vpc_internal.id

  allow {
    protocol = "tcp"
    ports = ["22" , "80" , "443"]
  }

  source_ranges = [
    "0.0.0.0/0"
  ]
}

resource "google_compute_firewall" "vpc_internal" {
  name = "${var.vpc_internal}-firewall"
  network = google_compute_network.vpc_internal.id

  allow {
    protocol = "tcp"
    ports = ["80" , "443" , "3306" , "5432"]
  }

  source_ranges = [
    "${google_compute_subnetwork.subnet_internal_a.ip_cidr_range}",
    "${google_compute_subnetwork.subnet_dev_a.ip_cidr_range}",
    "${google_compute_subnetwork.subnet_prod_a.ip_cidr_range}"
  ]
}

resource "google_compute_firewall" "vpc_dev" {
  name = "${var.vpc_dev}-firewall"
  network = google_compute_network.vpc_dev.id

  allow {
    protocol = "tcp"
    ports = ["80" , "443" , "3306" , "5432" , "22"]
  }

  source_ranges = [
    "${google_compute_subnetwork.subnet_internal_a.ip_cidr_range}",
    "${google_compute_subnetwork.subnet_dev_a.ip_cidr_range}",
    "${google_compute_subnetwork.subnet_prod_a.ip_cidr_range}"
  ]
}

resource "google_compute_firewall" "vpc_prod" {
  name = "${var.vpc_prod}-firewall"
  network = google_compute_network.vpc_prod.id

  allow {
    protocol = "tcp"
    ports = ["80" , "443" , "3306" , "5432" , "22"]
  }

  source_ranges = [
    "${google_compute_subnetwork.subnet_internal_a.ip_cidr_range}",
    "${google_compute_subnetwork.subnet_dev_a.ip_cidr_range}",
    "${google_compute_subnetwork.subnet_prod_a.ip_cidr_range}"
  ]
}