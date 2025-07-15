# Development Environment Variables
# These variables are specific to the development environment

# Include all variables from the root module
variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cloud_provider" {
  description = "Cloud provider to use (aws or gcp)"
  type        = string
}

# AWS Configuration
variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_availability_zones" {
  description = "AWS availability zones"
  type        = list(string)
}

# GCP Configuration
variable "gcp_project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "gcp_region" {
  description = "Google Cloud region"
  type        = string
}

# Application Configuration
variable "app_image" {
  description = "Container image for the application"
  type        = string
}

variable "app_port" {
  description = "Port on which the application runs"
  type        = number
}

variable "app_cpu" {
  description = "CPU allocation for the application"
  type        = string
}

variable "app_memory" {
  description = "Memory allocation for the application"
  type        = string
}

variable "app_desired_count" {
  description = "Desired number of application instances (AWS ECS)"
  type        = number
}

variable "app_min_instances" {
  description = "Minimum number of application instances (GCP Cloud Run)"
  type        = number
}

variable "app_max_instances" {
  description = "Maximum number of application instances (GCP Cloud Run)"
  type        = number
}

# Database Configuration
variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_instance_class" {
  description = "AWS RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "AWS RDS allocated storage (GB)"
  type        = number
}

variable "gcp_db_tier" {
  description = "GCP Cloud SQL instance tier"
  type        = string
}

# Network Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

# Additional Configuration
variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}

variable "enable_ssl_redirect" {
  description = "Enable SSL redirect"
  type        = bool
}

# Sensitive Variables
variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "jwt_secret" {
  description = "JWT secret key"
  type        = string
  sensitive   = true
  default     = ""
}
