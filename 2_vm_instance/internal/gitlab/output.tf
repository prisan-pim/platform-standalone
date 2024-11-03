output "config" {
  value = {
    vm-test-public = google_compute_instance.vm_public_ip.name
    public_ip = google_compute_address.public_ip.address
    private_ip = google_compute_address.private_ip.address
  }
}