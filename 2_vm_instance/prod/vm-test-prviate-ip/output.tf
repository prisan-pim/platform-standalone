output "config" {
  value = {
    vm-dev-private-ip = google_compute_instance.vm_private_ip.name
    private_ip = google_compute_address.private_ip.address
  }
}