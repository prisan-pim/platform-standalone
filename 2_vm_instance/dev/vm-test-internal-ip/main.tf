provider "google" {
  project = var.project
  region  = var.region
  credentials = file("../../../key.json")
}

resource "google_compute_address" "static_internal_ip" {
  name         = "${var.project_name}-internal-ip"
  address      = "${var.internal_address}"
  region       = var.region
  subnetwork   = var.subnet
  address_type = "INTERNAL"
}

resource "google_compute_instance" "tool" {
  name         = var.project_name
  machine_type = var.machine_type
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = var.os_config
    }
  }

  network_interface {
    network       = var.network
    subnetwork    = var.subnet
    network_ip = google_compute_address.static_internal_ip.address
  }

  metadata = {
    sshKeys = "ubuntu:${file(var.ssh_public_key_filepath)}"
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
  EOF
}
