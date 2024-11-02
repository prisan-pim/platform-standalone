
# Cloud NAT for VPC 1

resource "google_compute_router" "router" {
  name    = "${var.vpc_1}-router"
  region  = var.region
  network = google_compute_network.vpc_1.id

  
  bgp {
    asn = 64515
    advertise_mode    = "CUSTOM"
    keepalive_interval = 30

    advertised_groups = ["ALL_SUBNETS"]

    advertised_ip_ranges {
      range = "10.0.1.0/24"  
      description = "internal-subnet-a"
    }
    //--------- vpc dev ------------/
    advertised_ip_ranges {
      range = "10.1.1.0/24"  
      description = "dev-subnet-a"
    }
  
    // ----------- vpc prod ----------/
    advertised_ip_ranges {
      range = "10.2.1.0/24"  
      description = "prd-subnet-a"
    }
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.vpc_1}-router-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

## ---------------------------------------------------------


resource "google_compute_router" "router_vpc2" {
  name    = "${var.vpc_2}-router"
  region  = var.region
  network = google_compute_network.vpc_2.id

  bgp {
    asn = 64514
    advertise_mode    = "CUSTOM"
    keepalive_interval = 30

    advertised_groups = ["ALL_SUBNETS"]

    advertised_ip_ranges {
      range = "10.0.1.0/24"  
      description = "internal-subnet-a"
    }
    //--------- vpc dev ------------/
    advertised_ip_ranges {
      range = "10.1.1.0/24"  
      description = "dev-subnet-a"
    }
     
    // ----------- vpc prod ----------/
    advertised_ip_ranges {
      range = "10.2.1.0/24"  
      description = "prod-subnet-a"
    }
  }
}

resource "google_compute_router_nat" "nat_vpc2" {
  name                               = "${var.vpc_2}-router-nat"
  router                             = google_compute_router.router_vpc2.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

## ---------------------------------------------------------

resource "google_compute_router" "router_vpc3" {
  name    = "${var.vpc_3}-router"
  region  = var.region
  network = google_compute_network.vpc_3.id

  bgp {
    asn = 64513
    advertise_mode    = "CUSTOM"
    keepalive_interval = 30

    advertised_groups = ["ALL_SUBNETS"]

    advertised_ip_ranges {
      range = "10.0.1.0/24"  
      description = "internal-subnet-a"
    }
    //--------- vpc dev ------------/
    advertised_ip_ranges {
      range = "10.1.1.0/24"  
      description = "dev-subnet-a"
    }
     

    // ----------- vpc prod ----------/
    advertised_ip_ranges {
      range = "10.2.1.0/24"  
      description = "prod-subnet-a"
    }
  }
}

resource "google_compute_router_nat" "nat_vpc3" {
  name                               = "${var.vpc_3}-router-nat"
  router                             = google_compute_router.router_vpc3.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}