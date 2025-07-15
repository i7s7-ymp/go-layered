# Terraform Infrastructure Documentation

This directory contains Terraform configurations for deploying the Go layered application infrastructure to both AWS and Google Cloud Platform.

## 🏗️ Architecture Overview

The Terraform configuration supports deployment to both cloud providers with the following architecture:

### AWS Architecture
- **VPC** with public and private subnets
- **Application Load Balancer (ALB)** for traffic distribution
- **ECS Fargate** for containerized application hosting
- **RDS PostgreSQL** for database
- **AWS Secrets Manager** for sensitive data
- **CloudWatch** for logging and monitoring

### GCP Architecture
- **VPC Network** with custom subnet
- **Cloud Run** for serverless container hosting
- **Cloud SQL PostgreSQL** for database
- **Secret Manager** for sensitive data
- **Cloud Monitoring** for observability
- **VPC Connector** for private connectivity

## 📁 Directory Structure

```
terraform/
├── main.tf                    # Root module configuration
├── variables.tf               # Global variable definitions
├── outputs.tf                 # Output values
├── modules/
│   ├── aws/                   # AWS-specific resources
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── gcp/                   # GCP-specific resources
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── dev/                   # Development environment
    │   ├── main.tf
    │   ├── variables.tf
    │   └── terraform.tfvars
    ├── staging/               # Staging environment
    │   └── terraform.tfvars
    └── prod/                  # Production environment
        └── terraform.tfvars
```

## 🚀 Quick Start

### Prerequisites

1. **Terraform** (>= 1.0)
2. **Cloud Provider CLI** (AWS CLI or gcloud)
3. **Docker** (for building application images)

### AWS Prerequisites
```bash
# Install AWS CLI and configure
aws configure
```

### GCP Prerequisites
```bash
# Install gcloud and authenticate
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
```

### Deployment Steps

1. **Choose your cloud provider and environment**:
   ```bash
   cd terraform/environments/dev
   ```

2. **Edit configuration**:
   ```bash
   # Edit terraform.tfvars
   vim terraform.tfvars
   
   # Set cloud_provider to "aws" or "gcp"
   cloud_provider = "aws"  # or "gcp"
   ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Plan deployment**:
   ```bash
   terraform plan
   ```

5. **Apply configuration**:
   ```bash
   terraform apply
   ```

## ⚙️ Configuration

### Switching Cloud Providers

To switch between AWS and GCP, simply change the `cloud_provider` variable in your `terraform.tfvars`:

```hcl
# For AWS deployment
cloud_provider = "aws"

# For GCP deployment  
cloud_provider = "gcp"
```

### Environment-Specific Configuration

Each environment has its own configuration file:

- **Development**: `environments/dev/terraform.tfvars`
- **Staging**: `environments/staging/terraform.tfvars`
- **Production**: `environments/prod/terraform.tfvars`

### Key Variables

| Variable | Description | AWS Default | GCP Default |
|----------|-------------|-------------|-------------|
| `app_image` | Container image | `nginx:latest` | `nginx:latest` |
| `app_cpu` | CPU allocation | `256` | `256` |
| `app_memory` | Memory allocation | `512` | `512` |
| `db_instance_class` | Database instance | `db.t3.micro` | - |
| `gcp_db_tier` | GCP database tier | - | `db-f1-micro` |

## 🔐 Secrets Management

### AWS Secrets Manager
Sensitive data like database passwords are automatically stored in AWS Secrets Manager.

### GCP Secret Manager
For GCP deployments, secrets are stored in Google Cloud Secret Manager.

### Local Development
For development, you can create a `terraform.tfvars.secret` file (gitignored):

```hcl
db_password = "your-secure-password"
jwt_secret  = "your-jwt-secret"
```

## 🏷️ Resource Tagging/Labeling

All resources are automatically tagged/labeled with:
- Project name
- Environment
- Cloud provider
- Managed by Terraform

## 📊 Monitoring and Logging

### AWS
- **CloudWatch Logs** for application logs
- **CloudWatch Metrics** for monitoring
- **AWS X-Ray** for distributed tracing (optional)

### GCP
- **Cloud Logging** for application logs
- **Cloud Monitoring** for metrics and alerting
- **Cloud Trace** for distributed tracing (optional)

## 🔄 State Management

Configure remote state backends for production use:

### AWS S3 Backend
```hcl
backend "s3" {
  bucket = "your-terraform-state-bucket"
  key    = "go-layered/prod/terraform.tfstate"
  region = "us-west-2"
  
  # Optional: DynamoDB for state locking
  dynamodb_table = "terraform-state-lock"
  encrypt        = true
}
```

### GCP GCS Backend
```hcl
backend "gcs" {
  bucket = "your-terraform-state-bucket"
  prefix = "go-layered/prod"
}
```

## 🔧 Troubleshooting

### Common Issues

1. **Permission Errors**:
   - Ensure your AWS/GCP credentials have sufficient permissions
   - Check IAM roles and policies

2. **Resource Conflicts**:
   - Use unique project names
   - Check for existing resources with the same names

3. **Quota Limits**:
   - Verify cloud provider quotas
   - Request quota increases if needed

### Debugging Commands

```bash
# Enable detailed logging
export TF_LOG=DEBUG

# Validate configuration
terraform validate

# Format configuration
terraform fmt -recursive

# Check state
terraform state list
terraform state show <resource>
```

## 🧹 Cleanup

To destroy all resources:

```bash
cd terraform/environments/dev
terraform destroy
```

**⚠️ Warning**: This will permanently delete all resources. Use with caution, especially in production.

## 📚 Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Google Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [AWS ECS Best Practices](https://docs.aws.amazon.com/AmazonECS/latest/bestpracticesguide/)
- [GCP Cloud Run Best Practices](https://cloud.google.com/run/docs/tips)
