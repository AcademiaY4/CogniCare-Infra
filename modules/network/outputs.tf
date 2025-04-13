output "network_id" {
  description = "ID of the VPC network"
  value       = google_compute_network.vpc_network.id
}

output "subnetwork_id" {
  description = "ID of the VPC subnetwork"
  value       = google_compute_subnetwork.vpc_subnetwork.id
}

output "network_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.vpc_network.name
}

output "subnetwork_name" {
  description = "Name of the VPC subnetwork"
  value       = google_compute_subnetwork.vpc_subnetwork.name
}