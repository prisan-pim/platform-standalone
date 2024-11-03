# VPC internal peering network to dev
resource "google_compute_network_peering" "internal_dev" {
  name = "${var.vpc_internal}-peering-${var.vpc_dev}"
  network = google_compute_network.vpc_internal.self_link
  peer_network = google_compute_network.vpc_dev.self_link
  import_custom_routes = true
  export_custom_routes = true
  import_subnet_routes_with_public_ip = true
  export_subnet_routes_with_public_ip = true
}

# VPC dev peering network to internal
resource "google_compute_network_peering" "dev_internal" {
  name = "${var.vpc_dev}-peering-${var.vpc_internal}"
  network = google_compute_network.vpc_dev.self_link
  peer_network = google_compute_network.vpc_internal.self_link
  import_custom_routes = true
  export_custom_routes = true
  import_subnet_routes_with_public_ip = true
  export_subnet_routes_with_public_ip = true
}

# VPC internal peering network to prod
resource "google_compute_network_peering" "internal_prod" {
  name = "${var.vpc_internal}-peering-${var.vpc_prod}"
  network = google_compute_network.vpc_internal.self_link
  peer_network = google_compute_network.vpc_prod.self_link
  import_custom_routes = true
  export_custom_routes = true
  import_subnet_routes_with_public_ip = true
  export_subnet_routes_with_public_ip = true
}

# VPC internal peering network to prod
resource "google_compute_network_peering" "prod_internal" {
  name = "${var.vpc_prod}-peering-${var.vpc_internal}"
  network = google_compute_network.vpc_prod.self_link
  peer_network = google_compute_network.vpc_internal.self_link
  import_custom_routes = true
  export_custom_routes = true
  import_subnet_routes_with_public_ip = true
  export_subnet_routes_with_public_ip = true
}