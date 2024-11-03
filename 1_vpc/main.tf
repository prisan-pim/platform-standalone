# Craete VPC Name Of Internal
resource "google_compute_network" "vpc_internal" {
    name = var.vpc_internal
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_internal_a" {
    name = "${var.subnet_internal}-a"
    ip_cidr_range =  "10.0.1.0/24"
    region = var.region
    network = google_compute_network.vpc_internal.id
}

# Create  VPC Name Of Dev
resource "google_compute_network" "vpc_dev" {
    name = var.vpc_dev
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_dev_a" {
    name = "${var.subnet_dev}-a"
    ip_cidr_range =  "10.1.1.0/24"
    region = var.region
    network = google_compute_network.vpc_dev.id
}

# Create  VPC Name Of Prod
resource "google_compute_network" "vpc_prod" {
    name = var.vpc_prod
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_prod_a" {
    name = "${var.subnet_prod}-a"
    ip_cidr_range =  "10.2.1.0/24"
    region = var.region
    network = google_compute_network.vpc_prod.id
}
