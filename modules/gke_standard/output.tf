output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.primary.name
}

output "endpoint" {
  description = "The endpoint (IP address) of the GKE cluster's Kubernetes API server"
  value       = google_container_cluster.primary.endpoint
}

output "ca_certificate" {
  description = "The base64-encoded public certificate that is the root of trust for the Kubernetes cluster"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}