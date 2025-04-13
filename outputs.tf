output "kubeconfig_command" {
  description = "Command to configure kubectl for the created GKE  cluster."
  value = "gcloud container clusters get-credentials ${module.gke_cluster.cluster_name} --region ${var.region} --project ${var.project_id}"
}

output "cluster_name" {
  description = "GKE  Cluster Name"
  value       = module.gke_cluster.cluster_name
}

output "cluster_endpoint" {
  description = "GKE  Cluster Endpoint"
  value       = module.gke_cluster.endpoint
  sensitive   = true
}

output "network_name" {
  description = "Name of the VPC network created"
  value       = module.network.network_name
}

output "subnetwork_name" {
  description = "Name of the VPC subnetwork created"
  value       = module.network.subnetwork_name
}
