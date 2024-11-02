# VPC Peering between VPC 1 and VPC 2
resource "google_compute_network_peering" "vpc1_vpc2" {
  name         = "${var.vpc_1}-${var.vpc_2}"
  network      = google_compute_network.vpc_1.self_link
  peer_network = google_compute_network.vpc_2.self_link
  import_custom_routes = true
  export_custom_routes = true
  import_subnet_routes_with_public_ip = true
  export_subnet_routes_with_public_ip = true
}

resource "google_compute_network_peering" "vpc2_vpc1" {
  name         = "${var.vpc_2}-${var.vpc_1}"
  network      = google_compute_network.vpc_2.self_link
  peer_network = google_compute_network.vpc_1.self_link
  import_custom_routes = true
  export_custom_routes = true
  import_subnet_routes_with_public_ip = true
  export_subnet_routes_with_public_ip = true
}

# VPC Peering between VPC 1 and VPC 3
resource "google_compute_network_peering" "vpc1_vpc3" {
  name         = "${var.vpc_1}-${var.vpc_3}"
  network      = google_compute_network.vpc_1.self_link
  peer_network = google_compute_network.vpc_3.self_link
  import_custom_routes = true
  export_custom_routes = true
  import_subnet_routes_with_public_ip = true
  export_subnet_routes_with_public_ip = true
}

resource "google_compute_network_peering" "vpc3_vpc1" {
  name         = "${var.vpc_3}-${var.vpc_1}"
  network      = google_compute_network.vpc_3.self_link
  peer_network = google_compute_network.vpc_1.self_link
  import_custom_routes = true
  export_custom_routes = true
  import_subnet_routes_with_public_ip = true
  export_subnet_routes_with_public_ip = true
}

