output "cluster_name" {
  description = "GKE Autopilot Cluster Name"
  value       = google_container_cluster.autopilot_primary.name
}

output "cluster_endpoint" {
  description = "GKE Autopilot Cluster Endpoint"
  value       = google_container_cluster.autopilot_primary.endpoint
  sensitive   = true
}