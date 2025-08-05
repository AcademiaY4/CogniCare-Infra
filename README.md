# Cognicare Infra: Infrastructure as Code (IaC) Repo, Terraform on GCP

> This repository defines and provisions all **cloud infrastructure** for the Cognicare platform using **Terraform**.  
> It is designed to create a **secure, scalable, and production‑ready environment** in **Google Cloud Platform (GCP)** and integrates seamlessly with the **Cognicare application GitOps deployment pipeline**.

---

## 📜 Table of Contents
1. [Overview](#-overview)
2. [Architecture](#-architecture)
3. [Infrastructure Components](#-infrastructure-components)
4. [Repository Structure](#-repository-structure)
5. [Technology Stack](#-technology-stack)
6. [Modules Explained](#-modules-explained)
7. [CI/CD with Terraform](#-cicd-with-terraform)
8. [Security Considerations](#-security-considerations)
9. [Getting Started](#-getting-started)
10. [Running Locally](#-running-locally)
11. [Integration with Application Deployment](#-integration-with-application-deployment)
12. [Helpful Links](#-helpful-links)
13. [License](#-license)

---

## 🚀 Overview

This repository provisions:
- 🌐 **VPC network & subnetwork** for Cognicare services.
- ☁ **Google Kubernetes Engine (GKE)** cluster (Standard or Autopilot mode).
- 📦 **Google Artifact Registry (GAR)** repositories for container images.
- 🔌 Networking configuration for service-to-service communication.
- 🔄 GitHub Actions workflow for **automated infrastructure provisioning**.

The **Cognicare platform** (from [`academiay4/cognicare-app`](https://github.com/academiay4/cognicare-app)) runs on top of this infrastructure, using **GitOps** via ArgoCD for continuous deployment.

---

## 🏗 Architecture

```mermaid
graph TD
    subgraph "Terraform Infra Repo"
        A[Terraform Modules]
        A1[Network Module]
        A2[GKE Module]
        A3[Artifact Registry Module]
    end

    subgraph "Google Cloud"
        B[VPC Network & Subnetwork]
        C[GKE Cluster]
        D[Artifact Registry]
    end

    subgraph "Application Repo (GitOps)"
        E[Cognicare Microservices]
        F[ArgoCD]
    end

    A --> B
    A --> C
    A --> D
    E --> F
    F --> C
````

---

## 🧩 Infrastructure Components

| Component                             | Purpose                                                             |
| ------------------------------------- | ------------------------------------------------------------------- |
| **VPC & Subnetwork**                  | Provides an isolated, private network for Cognicare services.       |
| **GKE Standard Cluster**              | Runs Cognicare’s Kubernetes workloads with configurable node pools. |
| **GKE Autopilot (Optional)**          | Alternative managed mode (commented out in current config).         |
| **Artifact Registry**                 | Stores Docker images for Cognicare microservices.                   |
| **GitHub Actions Terraform Workflow** | Automates provisioning and updating of infrastructure.              |

---

## 📂 Repository Structure

```
academiay4-cognicare-infra/
├── backend.tf                # Remote Terraform state backend (GCS)
├── main.tf                   # Main module calls
├── outputs.tf                # Exported values (kubeconfig command, cluster name, etc.)
├── provider.tf               # Google provider configuration
├── variables.tf              # Input variables
├── modules/                  # Reusable Terraform modules
│   ├── network/              # VPC + subnetwork
│   ├── gke_standard/         # Standard GKE cluster + node pool
│   ├── gke_autopilot/        # Autopilot GKE cluster
│   ├── gar/                  # Google Artifact Registry
├── .github/workflows/        # CI/CD workflows
│   └── terraform.yaml        # Automated provisioning pipeline
└── .terraform.lock.hcl       # Provider dependency lock
```

---

## ⚙ Technology Stack

| Tool / Service                     | Purpose                        |
| ---------------------------------- | ------------------------------ |
| **Terraform**                      | Infrastructure as Code (IaC)   |
| **Google Cloud Platform (GCP)**    | Hosting provider               |
| **GKE (Google Kubernetes Engine)** | Managed Kubernetes cluster     |
| **Google Artifact Registry (GAR)** | Container image storage        |
| **Google Cloud VPC**               | Private network for workloads  |
| **GitHub Actions**                 | CI/CD automation               |
| **GCS (Google Cloud Storage)**     | Remote Terraform state backend |

---

## 📦 Modules Explained

### **1️⃣ Network Module (`modules/network`)**

Creates:

* VPC network (`google_compute_network`)
* Subnetwork (`google_compute_subnetwork`) with a custom CIDR range
* Private IP access for Google APIs

**Inputs:**

* `network_name`, `subnetwork_name`, `ip_cidr_range`, `project_id`, `region`

**Outputs:**

* `network_id`, `subnetwork_id`, `network_name`, `subnetwork_name`

---

### **2️⃣ GKE Standard Module (`modules/gke_standard`)**

Creates:

* Standard GKE cluster (VPC Native)
* Configurable **node pool** (machine type, disk type, node count)

**Inputs:**

* `cluster_name`, `zone`, `node_count`, `machine_type`, `disk_type`, `disk_size_gb`

**Outputs:**

* `cluster_name`, `endpoint`, `ca_certificate`

---

### **3️⃣ GKE Autopilot Module (`modules/gke_autopilot`)**

* Fully managed GKE cluster (autopilot mode).
* **Currently commented out** in `main.tf` but available for future use.

---

### **4️⃣ Artifact Registry Module (`modules/gar`)**

Creates:

* Multiple **Docker repositories** for Cognicare services.
* Example repos:

  * `admin-portal-service`
  * `mri-service`
  * `gateway-service`
  * `progress-tracking-service`
  * `treatment-planning-service`

---

## 🔄 CI/CD with Terraform

The `.github/workflows/terraform.yaml` workflow automates infrastructure changes:

### **Pipeline Steps**

1. **Trigger** → Runs on push to `master` branch.
2. **Checkout** → Clones repo into GitHub Actions runner.
3. **Authenticate** → Uses `google-github-actions/auth@v2` with a GCP service account key (`GCP_SA_KEY`).
4. **Terraform Init** → Initializes Terraform backend (GCS bucket for remote state).
5. **Terraform Plan** → Generates execution plan and uploads as artifact.
6. **Terraform Apply** → Applies infrastructure changes without manual approval (`-auto-approve`).

---

### **Secrets Used in Workflow**

| Secret            | Purpose                                     |
| ----------------- | ------------------------------------------- |
| `PROJECT_ID`      | GCP Project ID                              |
| `REGION`          | GCP Region                                  |
| `ZONE`            | GCP Zone                                    |
| `CLUSTER_NAME`    | GKE cluster name                            |
| `NETWORK_NAME`    | VPC network name                            |
| `SUBNETWORK_NAME` | Subnetwork name                             |
| `IP_CIDR_RANGE`   | Subnetwork CIDR block                       |
| `NODE_COUNT`      | Number of GKE nodes                         |
| `MACHINE_TYPE`    | GCP VM type                                 |
| `DISK_TYPE`       | GKE node disk type                          |
| `DISK_SIZE_GB`    | GKE node disk size                          |
| `TF_BUCKET`       | GCS bucket for Terraform state              |
| `GCP_SA_KEY`      | Base64‑encoded GCP service account key JSON |

---

## 🔐 Security Considerations

* **State file** → Stored in GCS bucket (remote backend) to avoid local state corruption.
* **Service account** → Has least privilege required for provisioning.
* **Secrets** → Stored in GitHub Actions **Secrets**.
* **Private networking** → GKE cluster is deployed in a private VPC.

---

## 🛠 Getting Started

### **1️⃣ Install Prerequisites**

* [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
* [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)

---

### **2️⃣ Authenticate to GCP**

```bash
gcloud auth application-default login
```

---

### **3️⃣ Configure Variables**

Either:

* Set them in `.tfvars` file
* Or pass them as CLI args:

```bash
terraform apply \
  -var="project_id=your-project" \
  -var="region=us-central1" \
  -var="zone=us-central1-a" \
  ...
```

---

### **4️⃣ Run Terraform Locally**

```bash
terraform init -backend-config="bucket=YOUR_TF_STATE_BUCKET"
terraform plan
terraform apply
```

---

## 🔗 Integration with Application Deployment

This infra repo is **the first step** in Cognicare’s deployment pipeline:

1. **This repo** provisions:

   * VPC
   * GKE cluster
   * Artifact Registry
2. **Application repo** builds & pushes Docker images to GAR.
3. **Manifest repo (GitOps)** updates Helm chart image tags.
4. **ArgoCD** syncs manifests to the GKE cluster.

---

## 📚 Helpful Links

* [Terraform GCP Provider Docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
* [GKE Documentation](https://cloud.google.com/kubernetes-engine/docs)
* [Google Artifact Registry Docs](https://cloud.google.com/artifact-registry)
* [Terraform Best Practices](https://developer.hashicorp.com/terraform/language)

---

## 📜 License

Licensed under the **MIT License**. See the [LICENSE](LICENSE) file.
