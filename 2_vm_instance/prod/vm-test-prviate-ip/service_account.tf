
resource "google_service_account" "scheduler_service_account" {
  account_id   = "${var.name_server}-scheduler"
  display_name = "VM Instance Scheduler Service Account"
}

resource "google_project_iam_member" "scheduler_role" {
  project = var.project_name
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.scheduler_service_account.email}"
}