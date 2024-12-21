
resource "google_container_cluster" "gke_cluster" {
  name     =  var.name
  location = var.region

  network    = var.network
  subnetwork = var.subnet

  enable_shielded_nodes    = "true"
  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.10.0.0/28"  

    
    master_global_access_config {
      enabled = false  
    }
  }

  timeouts {
    create = "60m"
    update = "60m"
  }

  lifecycle {
    ignore_changes = [node_pool]
  }

  resource_labels = {
    environment = "internal"
    owner = "internal"
  }

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.name}-pool"
  location   = var.region 
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 1
  

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 2
    max_node_count = 4
  }

  timeouts {
    create = "60m"
    update = "60m"
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type_group_one

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
