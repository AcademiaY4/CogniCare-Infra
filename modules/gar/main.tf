resource "google_artifact_registry_repository" "repositories" {
  for_each      = var.repositories
  repository_id = each.key
  format        = "DOCKER"
  location      = var.region
}
