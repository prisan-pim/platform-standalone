# Create Cloud NAT of Internal
resource "google_compute_router" "route_internal" {
  name = "${var.vpc_internal}-router"
  region = var.region
  network = google_compute_network.vpc_internal.id

  bgp {
    asn = 64515
    advertise_mode = "CUSTOM"
    keepalive_interval = 30

    advertised_groups = ["ALL_SUBNETS"]

    # VPC IP ranges Of Internal
    advertised_ip_ranges {
      range = "10.0.1.0/24"
      description = "internal-subnet-a"
    }

    # VPC IP ranges Of Dev
    advertised_ip_ranges {
      range = "10.1.1.0/24"
      description = "dev-subnet-a"
    }

    # VPC IP ranges Of Prod
    advertised_ip_ranges {
      range = "10.2.1.0/24"
      description = "prod-subnet-a"
    }
  }

}

resource "google_compute_router_nat" "router_internal_nat" {
  name = "${var.vpc_internal}-router-nat"
  router = google_compute_router.route_internal.name
  region = var.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# Create Cloud NAT of Dev
resource "google_compute_router" "route_dev" {
  name = "${var.vpc_dev}-router"
  region = var.region
  network = google_compute_network.vpc_dev.id

  bgp {
    asn = 64514
    advertise_mode = "CUSTOM"
    keepalive_interval = 30

    advertised_groups = ["ALL_SUBNETS"]

    # VPC IP ranges Of Internal
    advertised_ip_ranges {
      range = "10.0.1.0/24"
      description = "internal-subnet-a"
    }

    # VPC IP ranges Of Dev
    advertised_ip_ranges {
      range = "10.1.1.0/24"
      description = "dev-subnet-a"
    }

    # VPC IP ranges Of Prod
    advertised_ip_ranges {
      range = "10.2.1.0/24"
      description = "prod-subnet-a"
    }
  }
}

resource "google_compute_router_nat" "router_dev_nat" {
  name = "${var.vpc_dev}-router-nat"
  router = google_compute_router.route_dev.name
  region = var.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# Create Cloud NAT of Prod
resource "google_compute_router" "route_prod" {
  name = "${var.vpc_prod}-router"
  region = var.region
  network = google_compute_network.vpc_prod.id

  bgp {
    asn = 64513
    advertise_mode = "CUSTOM"
    keepalive_interval = 30

    advertised_groups = ["ALL_SUBNETS"]

    # VPC IP ranges Of Internal
    advertised_ip_ranges {
      range = "10.0.1.0/24"
      description = "internal-subnet-a"
    }

    # VPC IP ranges Of Dev
    advertised_ip_ranges {
      range = "10.1.1.0/24"
      description = "dev-subnet-a"
    }

    # VPC IP ranges Of Prod
    advertised_ip_ranges {
      range = "10.2.1.0/24"
      description = "prod-subnet-a"
    }
  }
}

resource "google_compute_router_nat" "router_prod_nat" {
  name = "${var.vpc_prod}-router-nat"
  router = google_compute_router.route_prod.name
  region = var.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}