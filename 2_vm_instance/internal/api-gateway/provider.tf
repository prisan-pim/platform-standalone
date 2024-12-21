provider "google" {
  project = var.project_name
  region  = var.region
  credentials = file("../../../key/key.json")
}