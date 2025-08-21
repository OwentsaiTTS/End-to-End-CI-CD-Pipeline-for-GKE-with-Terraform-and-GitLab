# End-to-End CI/CD Pipeline for GKE with Terraform and GitLab

A comprehensive personal project demonstrating a complete, end-to-end CI/CD pipeline to automate the deployment of a containerized web application from source code to a live environment on Google Cloud Platform (GCP). This project showcases hands-on expertise in modern DevOps principles and tooling.

---

## 🏛️ Architecture & Workflow

This project implements an event-driven automation workflow. A `git push` to the `master` branch on GitLab triggers a multi-stage CI/CD pipeline that handles the entire build, release, and deployment process without any manual intervention.

![Devops-project-workflow](./assets/screenshot.png)

## ✨ Key Features

* **Infrastructure as Code (IaC):** All cloud infrastructure (GKE Cluster, Node Pools, etc.) is defined declaratively using **Terraform**. This enables version-controlled, repeatable, and automated provisioning.
* **Automated Docker Builds:** Upon every commit, the CI/CD pipeline automatically builds the Python Flask application into a **Docker** image, tags it with the unique commit SHA for traceability, and pushes it to a private **GitLab Container Registry**.
* **Zero-Downtime Deployment:** The pipeline uses **Kubernetes** to orchestrate the deployment, ensuring the application is rolled out smoothly.
* **Secure Credential Management:** All sensitive credentials, such as the GCP Service Account Key and the GitLab Deploy Token, are securely stored as **GitLab CI/CD variables** and are never hardcoded in the repository.
* **Remote State Management:** Terraform's state is securely managed in a **Google Cloud Storage (GCS)** bucket with versioning enabled, allowing for team collaboration and preventing state corruption.

## 🛠️ Tech Stack

| Technology | Purpose |
| :--- | :--- |
| **Google Cloud Platform (GCP)** | Primary cloud provider for all infrastructure. |
| **Google Kubernetes Engine (GKE)** | Managed Kubernetes service for application orchestration. |
| **GitLab CI/CD** | Automation engine for the entire build and deployment pipeline. |
| **Terraform** | Infrastructure as Code tool for provisioning GCP resources. |
| **Docker** | Containerization for the Python application. |
| **Kubernetes** | Core container orchestration and application management. |
| **Python & Flask** | The web application framework. |

## 📖 Lessons Learned

This project was a deep dive into real-world troubleshooting. The key challenges and learnings included:
* **Cloud IAM & Scopes:** Navigating the complexities of GCP's permission model, understanding the critical difference between IAM Roles and OAuth Scopes, and correctly configuring Service Accounts (`Editor`, `Service Account User` roles) were the most challenging aspects.
* **IaC State Drift:** Encountered and resolved several `Already Exists` and `deletion_protection` errors. This provided hands-on experience with `terraform import` and the importance of synchronizing Terraform state with cloud reality.
* **CI/CD Environment Nuances:** Learned to handle the constraints of a non-interactive CI/CD runner, such as dynamically installing dependencies (`terraform`) and using non-interactive flags for commands (`unzip -o`, `terraform init -migrate-state`).
* **Kubernetes Networking & Auth:** Debugged the "last-mile" connectivity issues, starting from the external IP not being accessible. This involved troubleshooting GCP firewall rules, Kubernetes Services, Endpoints, and resolving the `ImagePullBackOff` error by implementing `imagePullSecrets` with a GitLab Deploy Token.
