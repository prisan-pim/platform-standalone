
resource "google_compute_address" "private_ip" {
  name = "${var.name_server}-private-ip"
  region = var.region
  subnetwork = var.subnet
  address = "10.1.1.10"
  address_type = "INTERNAL"
}

resource "google_compute_instance" "vm_private_ip" {
  name          = var.name_server
  machine_type  = var.machine_type
  zone          = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = var.image
      size = 20
    }
  }

  network_interface {
    network = var.vpc
    subnetwork = var.subnet
    network_ip = google_compute_address.private_ip.address
  }
  metadata = {
    sshKeys = "ubuntu:${file(var.file_account)}"
  }

}