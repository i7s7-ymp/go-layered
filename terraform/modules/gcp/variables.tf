# GCP Module Variables

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
}

variable "labels" {
  description = "Labels to apply to all resources"
  type        = map(string)
  default     = {}
}

# Application configuration
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

variable "app_min_instances" {
  description = "Minimum number of application instances"
  type        = number
}

variable "app_max_instances" {
  description = "Maximum number of application instances"
  type        = number
}

# Database configuration
variable "db_tier" {
  description = "Cloud SQL instance tier"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

# Network configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

# Additional configuration
variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}
