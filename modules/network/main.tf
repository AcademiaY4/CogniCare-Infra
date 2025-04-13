resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name                     = var.subnetwork_name
  project                  = var.project_id
  ip_cidr_range            = var.ip_cidr_range
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}