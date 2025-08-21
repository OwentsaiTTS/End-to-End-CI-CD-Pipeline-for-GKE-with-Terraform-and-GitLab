terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
}

# Configure the Google Cloud provider with project, region, and zone details.
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
  # Define the OAuth scopes for the provider's API calls.
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}

# Create a Google Kubernetes Engine (GKE) cluster.
resource "google_container_cluster" "primary" {
  name     = "devops-project-cluster"
  location = "asia-east1-b" # Set the location for the cluster control plane.
  
  # Disable deletion protection, allowing the cluster to be destroyed by Terraform.
  deletion_protection = false

  # This is a mandatory field for the API
  initial_node_count = 1
  # Remove the default node pool upon cluster creation. We will create a custom one instead.
  remove_default_node_pool = true
}

# Create a custom node pool for the GKE cluster.
resource "google_container_node_pool" "primary_nodes" {
  name     = "primary-node-pool"
  location = google_container_cluster.primary.location
  cluster  = google_container_cluster.primary.name
  
  # Set the desired number of nodes in this pool.
  node_count = 1

  node_config {
    preemptible = true
    machine_type = "e2-small"
    # Define the set of permissions for the nodes.
    # 'cloud-platform' provides full access to all Cloud APIs.
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Output the name of the created GKE cluster.
output "cluster_name" {
  value = google_container_cluster.primary.name
}

# Output the location of the created GKE cluster.
output "cluster_location" {
  value = google_container_cluster.primary.location
}