variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "repositories" {
  description = "Map of repository names"
  type        = map(string)
  default     = {}
}
