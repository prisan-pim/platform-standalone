provider "google" {
  project = var.project
  region  = var.region
  credentials = file("../key.json")
}

resource "google_compute_network" "vpc_1" {
  name                    = var.vpc_1
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1_vpc1" {
  name          = "${var.vpc_1}-subnet-1"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_1.id
}

# VPC 2 (dev) with subnets a
resource "google_compute_network" "vpc_2" {
  name                    = var.vpc_2
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_a_vpc2" {
  name          = "${var.vpc_2}-subnet-a"
  ip_cidr_range = "10.1.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_2.id
}

# VPC 3 (prod) with subnets a
resource "google_compute_network" "vpc_3" {
  name                    = var.vpc_3
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_a_vpc3" {
  name          = "${var.vpc_3}-subnet-a"
  ip_cidr_range = "10.2.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_3.id
}