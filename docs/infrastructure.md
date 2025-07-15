# Terraform Infrastructure Documentation

## Infrastructure Deployment Guide

For detailed instructions on deploying the infrastructure to AWS or Google Cloud Platform, see the [Infrastructure Guide](../terraform/README.md).

### Quick Start

1. **Choose your cloud provider**:
   ```bash
   cd terraform/environments/dev
   ```

2. **Edit configuration**:
   ```bash
   # Set cloud_provider to "aws" or "gcp" in terraform.tfvars
   cloud_provider = "aws"  # or "gcp"
   ```

3. **Deploy infrastructure**:
   ```bash
   # From project root
   ./terraform/scripts/deploy.sh -e dev -p aws -a apply
   ```

### Architecture Diagrams

#### AWS Architecture
```
Internet → ALB → ECS Fargate → RDS PostgreSQL
                    ↓
               CloudWatch Logs
```

#### GCP Architecture  
```
Internet → Cloud Run → Cloud SQL PostgreSQL
              ↓
         Cloud Logging
```

For complete infrastructure documentation, visit the [Terraform directory](../terraform/).
