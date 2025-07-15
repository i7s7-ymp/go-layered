# Global Variables
# These variables are used across all cloud providers and environments

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "go-layered"
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]+$", var.project_name))
    error_message = "Project name must contain only alphanumeric characters and hyphens."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "cloud_provider" {
  description = "Cloud provider to use (aws or gcp)"
  type        = string
  validation {
    condition     = contains(["aws", "gcp"], var.cloud_provider)
    error_message = "Cloud provider must be either 'aws' or 'gcp'."
  }
}

# AWS-specific variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "aws_availability_zones" {
  description = "AWS availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

# GCP-specific variables
variable "gcp_project_id" {
  description = "Google Cloud project ID"
  type        = string
  default     = ""
}

variable "gcp_region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-west2"
}

# Application configuration
variable "app_image" {
  description = "Container image for the application"
  type        = string
  default     = "nginx:latest"  # Replace with your actual application image
}

variable "app_port" {
  description = "Port on which the application runs"
  type        = number
  default     = 8080
}

variable "app_cpu" {
  description = "CPU allocation for the application"
  type        = string
  default     = "256"
}

variable "app_memory" {
  description = "Memory allocation for the application (MB)"
  type        = string
  default     = "512"
}

variable "app_desired_count" {
  description = "Desired number of application instances (AWS ECS)"
  type        = number
  default     = 2
}

variable "app_min_instances" {
  description = "Minimum number of application instances (GCP Cloud Run)"
  type        = number
  default     = 0
}

variable "app_max_instances" {
  description = "Maximum number of application instances (GCP Cloud Run)"
  type        = number
  default     = 10
}

# Database configuration
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "app_db"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "app_user"
}

variable "db_instance_class" {
  description = "AWS RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "AWS RDS allocated storage (GB)"
  type        = number
  default     = 20
}

variable "gcp_db_tier" {
  description = "GCP Cloud SQL instance tier"
  type        = string
  default     = "db-f1-micro"
}

# Network configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

# Additional configuration
variable "domain_name" {
  description = "Domain name for the application (optional)"
  type        = string
  default     = ""
}

variable "enable_ssl_redirect" {
  description = "Enable SSL redirect for load balancer"
  type        = bool
  default     = true
}

# Secrets configuration
variable "db_password" {
  description = "Database password (sensitive)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "jwt_secret" {
  description = "JWT secret key (sensitive)"
  type        = string
  sensitive   = true
  default     = ""
}
