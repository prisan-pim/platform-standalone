output "cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "cluster_private_endpoint" {
  value = google_container_cluster.gke_cluster.private_cluster_config[0].private_endpoint
}

output "cluster_location" {
  value = google_container_cluster.gke_cluster.location
}