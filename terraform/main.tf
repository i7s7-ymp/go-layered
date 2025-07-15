# Main Terraform configuration
# This file defines the infrastructure for the Go layered application
# Supports both AWS and Google Cloud providers

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  # Backend configuration - uncomment and configure based on your needs
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "go-layered/terraform.tfstate"
  #   region = "us-west-2"
  # }
  
  # backend "gcs" {
  #   bucket = "your-terraform-state-bucket"
  #   prefix = "go-layered"
  # }
}

# Local values for common configuration
locals {
  project_name = var.project_name
  environment  = var.environment
  cloud_provider = var.cloud_provider
  
  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "terraform"
    Repository  = "go-layered"
  }

  # AWS-specific tags
  aws_tags = merge(local.common_tags, {
    Provider = "aws"
  })

  # GCP-specific labels
  gcp_labels = merge(local.common_tags, {
    provider = "gcp"
  })
}

# AWS Provider configuration
provider "aws" {
  count  = var.cloud_provider == "aws" ? 1 : 0
  region = var.aws_region
  
  default_tags {
    tags = local.aws_tags
  }
}

# Google Cloud Provider configuration
provider "google" {
  count   = var.cloud_provider == "gcp" ? 1 : 0
  project = var.gcp_project_id
  region  = var.gcp_region
}

provider "google-beta" {
  count   = var.cloud_provider == "gcp" ? 1 : 0
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Random suffix for unique resource naming
resource "random_id" "suffix" {
  byte_length = 4
}

# AWS Infrastructure
module "aws_infrastructure" {
  count  = var.cloud_provider == "aws" ? 1 : 0
  source = "./modules/aws"

  project_name = local.project_name
  environment  = local.environment
  aws_region   = var.aws_region
  
  # Application configuration
  app_image         = var.app_image
  app_port          = var.app_port
  app_cpu           = var.app_cpu
  app_memory        = var.app_memory
  app_desired_count = var.app_desired_count
  
  # Database configuration
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_name             = var.db_name
  db_username         = var.db_username
  
  # Network configuration
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.aws_availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  
  # Additional configuration
  enable_ssl_redirect = var.enable_ssl_redirect
  domain_name        = var.domain_name
  
  tags = local.aws_tags
}

# Google Cloud Infrastructure
module "gcp_infrastructure" {
  count  = var.cloud_provider == "gcp" ? 1 : 0
  source = "./modules/gcp"

  project_name   = local.project_name
  environment    = local.environment
  gcp_project_id = var.gcp_project_id
  gcp_region     = var.gcp_region
  
  # Application configuration
  app_image         = var.app_image
  app_port          = var.app_port
  app_cpu           = var.app_cpu
  app_memory        = var.app_memory
  app_min_instances = var.app_min_instances
  app_max_instances = var.app_max_instances
  
  # Database configuration
  db_tier     = var.gcp_db_tier
  db_name     = var.db_name
  db_username = var.db_username
  
  # Network configuration
  vpc_cidr = var.vpc_cidr
  
  # Additional configuration
  domain_name = var.domain_name
  
  labels = local.gcp_labels
}
