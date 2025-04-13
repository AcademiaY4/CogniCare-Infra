module "network" {
  source          = "./modules/network"
  project_id      = var.project_id
  region          = var.region
  network_name    = var.network_name
  subnetwork_name = var.subnetwork_name
  ip_cidr_range   = var.ip_cidr_range
}

# module "gke_autopilot" {
#   source        = "./modules/gke_autopilot"
#   project_id    = var.project_id
#   region        = var.region
#   cluster_name  = var.cluster_name
#   network_id    = module.network.network_id
#   subnetwork_id = module.network.subnetwork_id
# }

module "gke_cluster" {
  source        = "./modules/gke_standard"
  project_id    = var.project_id
  zone          = var.zone
  node_count    = var.node_count
  machine_type  = var.machine_type
  disk_size_gb  = var.disk_size_gb
  disk_type     = var.disk_type
  cluster_name  = var.cluster_name
  network_id    = module.network.network_id
  subnetwork_id = module.network.subnetwork_id
}

module "artifact_registry" {
  source     = "./modules/gar"
  project_id = var.project_id
  region     = var.region

  repositories = {
    "admin-portal-service"       = "Admin Client Service"
    "mri-service"                = "MRI Service"
    "gateway-service"            = "API Gateway Service"
    "progress-tracking-service"  = "Progress Tracking Service"
    "treatment-planning-service" = "Treatment Planning Service"
  }
}
