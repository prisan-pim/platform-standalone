
resource "google_compute_address" "public_ip" {
  name = "${var.name_server}-public-ip"
  region = var.region
  address_type = "EXTERNAL"
}

resource "google_compute_address" "private_ip" {
  name = "${var.name_server}-private-ip"
  region = var.region
  subnetwork = var.subnet
  address = var.ip_address
  address_type = "INTERNAL"
}

resource "google_compute_instance" "vm_public_ip" {
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
    access_config {
      nat_ip = google_compute_address.public_ip.address
    }
  }
  metadata = {
    sshKeys = "ubuntu:${file(var.file_account)}"
  }

}