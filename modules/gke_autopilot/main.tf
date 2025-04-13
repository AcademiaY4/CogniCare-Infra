resource "google_container_cluster" "autopilot_primary" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.region

  network    = var.network_id
  subnetwork = var.subnetwork_id
  networking_mode = "VPC_NATIVE"

  enable_autopilot = true
  deletion_protection = false

  ip_allocation_policy {}

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}