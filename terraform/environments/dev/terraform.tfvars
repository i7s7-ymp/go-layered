# Development Environment Configuration
# This file contains development-specific variable values

project_name   = "go-layered"
environment    = "dev"
cloud_provider = "aws"  # Change to "gcp" to deploy on Google Cloud

# AWS Configuration
aws_region             = "us-west-2"
aws_availability_zones = ["us-west-2a", "us-west-2b"]

# GCP Configuration (used when cloud_provider = "gcp")
gcp_project_id = "your-gcp-project-id"  # Replace with your actual GCP project ID
gcp_region     = "us-west2"

# Application Configuration
app_image         = "nginx:latest"  # Replace with your application image
app_port          = 8080
app_cpu           = "256"
app_memory        = "512"
app_desired_count = 1  # AWS ECS
app_min_instances = 0  # GCP Cloud Run
app_max_instances = 5  # GCP Cloud Run

# Database Configuration
db_name               = "app_db_dev"
db_username           = "app_user"
db_instance_class     = "db.t3.micro"     # AWS RDS
db_allocated_storage  = 20                # AWS RDS (GB)
gcp_db_tier          = "db-f1-micro"      # GCP Cloud SQL

# Network Configuration
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]

# Additional Configuration
domain_name         = ""     # Optional: your domain name
enable_ssl_redirect = false  # Set to true if you have SSL certificate

# Sensitive Variables (set via environment variables or terraform.tfvars.secret)
# db_password = "your-secure-database-password"
# jwt_secret  = "your-jwt-secret-key"
