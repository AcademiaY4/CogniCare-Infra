variable "project_id" {
  description = "The Google Cloud project ID to deploy resources into."
  type        = string
}

variable "region" {
  description = "The Google Cloud region to deploy resources into."
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