variable "project_id" {
  description = "The Google Cloud project ID to deploy resources into."
  type        = string
}

variable "region" {
  description = "The Google Cloud region to deploy resources into."
  type        = string
}
variable "zone" {
  description = "The Google Cloud zone to deploy resources into."
  type        = string
}
variable "network_name" {
  description = "The name for the VPC network."
  type        = string
}

variable "subnetwork_name" {
  description = "The name for the VPC subnetwork."
  type        = string
}

variable "ip_cidr_range" {
  description = "The IP CIDR range for the subnetwork."
  type        = string
}

variable "cluster_name" {
  description = "The name for the GKE Autopilot cluster."
  type        = string
}
variable "node_count" {
  description = "The number of nodes in the default node pool"
  type        = number
}

variable "machine_type" {
  description = "The machine type to use for the nodes in the cluster (e.g., e2-medium)"
  type        = string
}

variable "disk_type" {
  description = "The type of disk to use for node VMs (e.g., pd-standard or pd-ssd)"
  type        = string
}

variable "disk_size_gb" {
  description = "The size of the boot disk in GB for each node"
  type        = number
}
