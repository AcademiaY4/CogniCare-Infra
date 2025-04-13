output "repositories" {
  description = "Map of repository names and URLs"
  value = {
    for repo_name, repo in google_artifact_registry_repository.repositories :
    repo_name => repo.id
  }
}