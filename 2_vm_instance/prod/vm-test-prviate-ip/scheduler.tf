
resource "google_cloud_scheduler_job" "start_instance" {
  name        = "${var.project_name}-start"
  description = "Start the VM instance"

  schedule   = "0 9 * * 1-5"
  time_zone  = "Asia/Bangkok"
  http_target {
    http_method = "POST"
    uri         = "https://compute.googleapis.com/compute/v1/projects/${var.project_name}/zones/asia-southeast1-a/instances/${google_compute_instance.vm_private_ip.name}/start"

     oauth_token {
      service_account_email = google_service_account.scheduler_service_account.email
    }
  }
}

resource "google_cloud_scheduler_job" "stop_instance" {
  name        = "${var.project_name}-stop"
  description = "Stop the VM instance"

  schedule   = "0 19 * * 1-5"
  time_zone  = "Asia/Bangkok"
  http_target {
    http_method = "POST"
    uri         = "https://compute.googleapis.com/compute/v1/projects/${var.project_name}/zones/asia-southeast1-a/instances/${google_compute_instance.vm_private_ip.name}/stop"

    oauth_token {
      service_account_email = google_service_account.scheduler_service_account.email
    }
    
  }
}