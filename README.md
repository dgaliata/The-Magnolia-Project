# The-Magnolia-Project
<img src="https://res.cloudinary.com/dcu6gtw2y/image/upload/v1742615267/Magnolia_Project_logo_tbyrjc.png" alt="Magnolia Project logo" width="250">

# 🌿 The Magnolia Project

> A fictitious biomedical company used as a hands-on DevOps and cloud security portfolio project.

---

## Overview

The Magnolia Project is a secure, cloud-based infrastructure built on AWS using Terraform for automation, FastAPI for backend APIs, React for the frontend, and monitoring tools like Prometheus and Grafana. The focus is on infrastructure automation, containerized application deployment, CI/CD integration, security best practices, and performance monitoring.

> **Note:** This is a personal portfolio project. All components and configurations are subject to change.

---

## Applications

### Scientific Data App
A full-stack application for scientists to securely upload, manage, and track experimental data and projects.

- **Frontend:** React
- **Backend:** FastAPI
- **Database:** PostgreSQL (AWS RDS)
- **File Storage:** S3

### Auth Service
Handles user authentication and issues JWTs consumed by the Scientific Data App.

- **Backend:** FastAPI
- **Identity Provider:** AWS Cognito + Google OAuth ("Login with Google")

---

## Project Phases

### Phase 1 — AWS Foundation (Terraform)

All infrastructure is provisioned via Terraform before any application code is deployed.

**Networking**
- VPC with public and private subnets across multiple availability zones
- Route tables, internet gateway, NAT gateway
- Security groups (scoped per service — ALB, ECS, RDS)
- NACLs for subnet-level traffic control

**Compute**
- ECS cluster (Fargate — serverless containers, no EC2 management)
- Application Load Balancer (ALB) with target groups and listeners
- ECR repositories (one per app) for Docker image storage

**Data**
- RDS PostgreSQL on `db.t3.micro` (free tier), deployed in a private subnet
- S3 buckets for experiment file uploads and static assets
- AWS Secrets Manager for database credentials and OAuth keys

**IAM**
- ECS task execution role (shared across tasks)
- Per-app ECS task roles with least-privilege policies
- Cognito User Pool with Google as a federated identity provider

---

### Phase 2 — Application Code

```
apps/
  scientific-data/
    frontend/             # React
    backend/              # FastAPI
    Dockerfile.frontend
    Dockerfile.backend
  auth-service/
    backend/              # FastAPI (handles Cognito/Google login flow)
    Dockerfile.backend

shared/
  auth/                   # JWT validation middleware
  db/                     # Database connection and base models
  utils/                  # Shared utilities
```

A `docker-compose.yml` at the root runs the full stack locally — both apps and a local PostgreSQL instance.

**Local dev vs. production auth:**

| | Local | ECS / Production |
|---|---|---|
| App-to-AWS | IAM user / AWS CLI profile | IAM Task Role (automatic) |
| User auth | Disabled / mock user | Cognito + Google OAuth |
| Secrets | `.env` file (gitignored) | AWS Secrets Manager |

---

### Phase 3 — CI/CD (CircleCI + ArgoCD)

**CircleCI** — build and test pipeline:
- On pull request → lint, unit tests, security scans (`bandit` for Python, `checkov` for Terraform)
- On merge to `main` → build Docker images, push to ECR, update deployment manifests with new image tags

**ArgoCD** — GitOps deployment:
- Watches the `deployments/` directory for manifest changes
- Automatically syncs updated task definitions and service configs to ECS

```
deployments/
  scientific-data/
    task-definition.json
    service.json
  auth-service/
    task-definition.json
    service.json
```

---

### Phase 4 — Monitoring & Observability

| Tool | Role |
|---|---|
| Prometheus | Scrapes `/metrics` from FastAPI apps via `prometheus-fastapi-instrumentator` |
| Grafana | Dashboards for request latency, error rates, and ECS task health |
| AWS CloudWatch | ECS task logs via `awslogs` driver; infrastructure-level metrics |
| AWS SNS | Alerts triggered by CloudWatch alarms (email / Slack) |
| AWS GuardDuty | Continuous threat detection on the account |
| AWS CloudTrail | Audit log of all AWS API activity |

---

## Repo Structure

```
magnolia-project/
├── terraform/
│   ├── networking/
│   ├── compute/
│   ├── database/
│   ├── storage/
│   ├── iam/
│   └── cognito/
├── apps/
│   ├── scientific-data/
│   │   ├── frontend/
│   │   ├── backend/
│   │   ├── Dockerfile.frontend
│   │   └── Dockerfile.backend
│   └── auth-service/
│       ├── backend/
│       └── Dockerfile.backend
├── shared/
│   ├── auth/
│   ├── db/
│   └── utils/
├── deployments/
│   ├── scientific-data/
│   └── auth-service/
├── monitoring/
│   ├── prometheus/
│   └── grafana/
├── .circleci/
│   └── config.yml
├── docker-compose.yml
└── README.md
```

---

## Tech Stack

| Category | Technology |
|---|---|
| Cloud | AWS (ECS Fargate, RDS, S3, ECR, VPC, IAM, KMS, Cognito) |
| IaC | Terraform |
| Backend | FastAPI (Python) |
| Frontend | React |
| Database | PostgreSQL on AWS RDS |
| Containerization | Docker, AWS ECS Fargate |
| CI/CD | CircleCI, ArgoCD |
| Monitoring | Prometheus, Grafana, AWS CloudWatch |
| Security | GuardDuty, CloudTrail, AWS Secrets Manager, KMS |

---

## Build Order

```
Phase 1 (Terraform)
  networking → iam → compute → database → storage → cognito

Phase 2 (Apps)
  auth-service → shared lib → scientific-data

Phase 3 (CI/CD)
  CircleCI pipelines → ArgoCD setup → deployment manifests

Phase 4 (Monitoring)
  Prometheus → Grafana → CloudWatch alarms → SNS alerts
```

---
## Misc.

### Application Monitoring

Use AWS CloudWatch to monitor FastAPI application health and log errors.

### Threat Detection

Implement AWS GuardDuty for continuous security monitoring.

### Incident Response

Develop and test incident response playbooks to ensure readiness.

### Notifications

Utilize AWS SNS and other tools for alerting and notifications when monitoring thresholds are breached.

*The Magnolia Project is designed to showcase my skills in deploying a secure, automated cloud infrastructure using modern DevOps practices. I created this project to get more hands-on experience with both infrastructure management and application development while emphasizing security and scalability.*
