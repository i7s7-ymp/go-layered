# Development Environment Terraform Configuration

terraform {
  required_version = ">= 1.0"
  
  # Configure backend for state management
  # Uncomment and configure based on your preference
  
  # AWS S3 Backend
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket-dev"
  #   key    = "go-layered/dev/terraform.tfstate"
  #   region = "us-west-2"
  #   
  #   # Optional: DynamoDB table for state locking
  #   # dynamodb_table = "terraform-state-lock"
  #   # encrypt        = true
  # }
  
  # GCP GCS Backend
  # backend "gcs" {
  #   bucket = "your-terraform-state-bucket-dev"
  #   prefix = "go-layered/dev"
  # }
}

# Use the root module
module "infrastructure" {
  source = "../../"

  # Pass all variables from terraform.tfvars
  project_name   = var.project_name
  environment    = var.environment
  cloud_provider = var.cloud_provider

  # AWS Configuration
  aws_region             = var.aws_region
  aws_availability_zones = var.aws_availability_zones

  # GCP Configuration
  gcp_project_id = var.gcp_project_id
  gcp_region     = var.gcp_region

  # Application Configuration
  app_image         = var.app_image
  app_port          = var.app_port
  app_cpu           = var.app_cpu
  app_memory        = var.app_memory
  app_desired_count = var.app_desired_count
  app_min_instances = var.app_min_instances
  app_max_instances = var.app_max_instances

  # Database Configuration
  db_name               = var.db_name
  db_username           = var.db_username
  db_instance_class     = var.db_instance_class
  db_allocated_storage  = var.db_allocated_storage
  gcp_db_tier          = var.gcp_db_tier

  # Network Configuration
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  # Additional Configuration
  domain_name         = var.domain_name
  enable_ssl_redirect = var.enable_ssl_redirect

  # Sensitive Variables
  db_password = var.db_password
  jwt_secret  = var.jwt_secret
}

# Output important values
output "infrastructure_summary" {
  description = "Summary of deployed infrastructure"
  value       = module.infrastructure.infrastructure_summary
}

output "application_url" {
  description = "Application URL"
  value       = module.infrastructure.application_url
}
