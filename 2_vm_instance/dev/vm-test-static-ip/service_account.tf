resource "google_service_account" "scheduler_service_account" {
  account_id   = "${var.project_name}-scheduler"
  display_name = "VM Instance Scheduler Service Account"
}

resource "google_project_iam_member" "openvpn_scheduler_role" {
  project = var.project
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.scheduler_service_account.email}"
}