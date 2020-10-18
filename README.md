# Development toolboxes

Maintained and reproducible development environments

## Set up

Create a Docker Hub service account
1. Fork this repo and add the following secrets:
  - `DOCKERHUB_USERNAME` == service account with collaborator rights on the Docker Hub repo
  - `DOCKERHUB_TOKEN` == the personal access token of the service account
2. Restart the GitHub Actions build to push the containers to the Docker Hub repo


