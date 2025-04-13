variable "project_id" {
  description = "The Google Cloud project ID to deploy resources into."
  type        = string
}

variable "region" {
  description = "The Google Cloud region to deploy resources into."
  type        = string
}

variable "cluster_name" {
  description = "The name for the GKE Autopilot cluster."
  type        = string
}

variable "network_id" {
  description = "The ID of the VPC network."
  type        = string
}

variable "subnetwork_id" {
  description = "The ID of the VPC subnetwork."
  type        = string
}
