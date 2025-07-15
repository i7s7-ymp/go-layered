# AWS Module Variables

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
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

variable "app_desired_count" {
  description = "Desired number of application instances"
  type        = number
}

# Database configuration
variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
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

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

# Additional configuration
variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}

variable "enable_ssl_redirect" {
  description = "Enable SSL redirect"
  type        = bool
}
