variable "project_id" {
  description = "The ID of the GCP project where resources will be created"
  type        = string
}

variable "zone" {
  description = "The GCP zone where the GKE cluster and other resources will be deployed"
  type        = string
}

variable "cluster_name" {
  description = "The name to assign to the GKE cluster"
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