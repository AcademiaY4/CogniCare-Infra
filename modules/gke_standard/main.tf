resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone
  project  = var.project_id

  network         = var.network_id
  subnetwork      = var.subnetwork_id
  networking_mode = "VPC_NATIVE"

  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  ip_allocation_policy {}
}

resource "google_container_node_pool" "primary_nodes" {
  name     = "${var.cluster_name}-node-pool"
  location = var.zone
  cluster  = google_container_cluster.primary.name
  project  = var.project_id

  node_count = var.node_count

  node_config {
    machine_type = var.machine_type

    disk_type    = var.disk_type
    disk_size_gb = var.disk_size_gb

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
