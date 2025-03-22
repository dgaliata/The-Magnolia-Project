# The-Magnolia-Project
Please see [this link](https://magnolia-project.hashnode.space/project-docs/project-overview) for more information.
# Overview

The Magnolia Project is a fictitious biomedical company. As a DevOps engineer 
and security practitioner, you will build a secure, cloud-based infrastructure on AWS using Terraform for automation, FastAPI for both web applications and APIs, and monitoring tools like Prometheus and Grafana. The focus is on infrastructure automation, CI/CD integration, security best practices, and performance monitoring.

# Project Components

## Infrastructure as Code (IaC) with Terraform ![terraform](https://img.icons8.com/?size=40&id=kEkT1u7zTDk5&format=png&color=000000)

### AWS Resources 
Use Terraform to provision core AWS components such as EC2 instances, S3 buckets, VPCs, security groups, IAM roles, and more.

### Automation
Automate the setup and configuration of cloud infrastructure to streamline deployments and enforce consistency.

## FastAPI Applications ![api](https://img.icons8.com/?size=40&id=21896&format=png&color=000000)

### Employee Directory App

A CRUD web application to manage employee data.

Leverages FastAPI’s templating capabilities (via Jinja2) for rendering HTML and serving CSS/JavaScript for a full-featured UI.

### Scientific Data Management App

A FastAPI-based application for scientists to submit experimental data and track projects.

Provides both a user-friendly web interface and robust API endpoints.

### Authentication Service

Integrates with an identity provider to manage user authentication and access control.

Built using FastAPI to unify the API layer and any dynamic web content.

## Database ![db](https://img.icons8.com/?size=40&id=NFQusZJ4neki&format=png&color=000000)

### DynamoDB

Use DynamoDB for storing all application data (both structured employee information and unstructured experimental metadata).

Benefits include scalability, high performance, built-in encryption at rest, and a flexible schema design that suits varying data types.

## CI/CD Pipelines ![ci](https://img.icons8.com/?size=40&id=4UYHY7QgwtFu&format=png&color=000000) 

### GitHub Actions

Implement a CI/CD pipeline to automate testing, integration, and deployment of FastAPI applications and Terraform configurations.

Include automated security checks and code quality assessments in the workflow.

## Security Integration ![sec](https://img.icons8.com/?size=40&id=0tpqgxISselU&format=png&color=000000)

### IAM Policies

Enforce the principle of least privilege across AWS resources.

Audit and Monitoring:

Utilize AWS CloudTrail for logging, CloudWatch for infrastructure monitoring, and AWS GuardDuty for threat detection.

### Encryption

Enable encryption for data at rest (DynamoDB and S3) using AWS KMS.

### CI/CD Security

Integrate security scans and best practices checks within the CI/CD pipelines.

## Employee Directory ![employee](https://img.icons8.com/?size=40&id=108347&format=png&color=000000)

### Development

Build the employee directory as a FastAPI application that manages users, roles, and attributes.

Render web pages using FastAPI’s Jinja2 templates and serve static assets (CSS, JavaScript) using Starlette’s StaticFiles.

### Data Storage

Store employee data in DynamoDB with encryption enabled, ensuring scalability and security.

## Networking & Storage ![network](https://img.icons8.com/?size=40&id=13569&format=png&color=000000)

### VPC Configuration

Create a VPC with subnets and security groups tailored for different components.

### S3 Storage

Use S3 for storing experiment data and other assets.

Implement lifecycle policies to manage storage costs and move data to Glacier for long-term retention.

### Security Controls

Configure security groups and NACLs to control inbound/outbound network access.

## Scientific Experiment Data

### Interface Development

Build an interface with FastAPI for scientists to securely upload and manage experimental data.

### Data Storage

Store experimental data in S3, with metadata management and lifecycle policies in place.

## Monitoring & Dashboards (Prometheus & Grafana) ![metrics](https://img.icons8.com/?size=40&id=12308&format=png&color=000000)

### Metrics Collection

Deploy Prometheus to gather performance metrics from your FastAPI applications and AWS infrastructure.

### Visualization

Use Grafana (or Grafana Cloud on an EC2 instance) for visualizing metrics and creating dashboards.

### Alerting

Set up alerts for system health, performance issues, and potential security incidents.

## Documentation ![documenta](https://img.icons8.com/?size=40&id=QanbId3SGVR7&format=png&color=000000)

### Project Documentation

Use Hashnode Docs to create comprehensive project documentation.

### Diagrams

Utilize Eraser io for creating network and architecture diagrams (https://www.eraser.io/).

## Monitoring & Incident Response ![metrics](https://img.icons8.com/?size=40&id=14835&format=png&color=000000)

### Application Monitoring

Use AWS CloudWatch to monitor FastAPI application health and log errors.

### Threat Detection

Implement AWS GuardDuty for continuous security monitoring.

### Incident Response

Develop and test incident response playbooks to ensure readiness.

### Notifications

Utilize AWS SNS for alerting and notifications when monitoring thresholds are breached.

The Magnolia Project is designed to showcase my skills in deploying a secure, automated cloud infrastructure using modern DevOps practices. I created this project to get more hands-on experience with both infrastructure management and application development while emphasizing security and scalability.
