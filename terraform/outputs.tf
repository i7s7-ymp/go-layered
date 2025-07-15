# Output values for both AWS and GCP infrastructures

# AWS Outputs
output "aws_application_url" {
  description = "URL of the deployed application on AWS"
  value       = var.cloud_provider == "aws" ? module.aws_infrastructure[0].application_url : null
}

output "aws_database_endpoint" {
  description = "AWS RDS database endpoint"
  value       = var.cloud_provider == "aws" ? module.aws_infrastructure[0].database_endpoint : null
  sensitive   = true
}

output "aws_vpc_id" {
  description = "AWS VPC ID"
  value       = var.cloud_provider == "aws" ? module.aws_infrastructure[0].vpc_id : null
}

output "aws_load_balancer_dns" {
  description = "AWS Application Load Balancer DNS name"
  value       = var.cloud_provider == "aws" ? module.aws_infrastructure[0].load_balancer_dns : null
}

output "aws_ecs_cluster_name" {
  description = "AWS ECS cluster name"
  value       = var.cloud_provider == "aws" ? module.aws_infrastructure[0].ecs_cluster_name : null
}

# GCP Outputs
output "gcp_application_url" {
  description = "URL of the deployed application on GCP"
  value       = var.cloud_provider == "gcp" ? module.gcp_infrastructure[0].application_url : null
}

output "gcp_database_connection_name" {
  description = "GCP Cloud SQL connection name"
  value       = var.cloud_provider == "gcp" ? module.gcp_infrastructure[0].database_connection_name : null
  sensitive   = true
}

output "gcp_vpc_name" {
  description = "GCP VPC network name"
  value       = var.cloud_provider == "gcp" ? module.gcp_infrastructure[0].vpc_name : null
}

output "gcp_cloud_run_service_name" {
  description = "GCP Cloud Run service name"
  value       = var.cloud_provider == "gcp" ? module.gcp_infrastructure[0].cloud_run_service_name : null
}

# Common outputs (independent of cloud provider)
output "project_name" {
  description = "Project name"
  value       = var.project_name
}

output "environment" {
  description = "Environment"
  value       = var.environment
}

output "cloud_provider" {
  description = "Cloud provider used"
  value       = var.cloud_provider
}

output "application_url" {
  description = "Application URL (unified output)"
  value = var.cloud_provider == "aws" ? (
    var.cloud_provider == "aws" ? module.aws_infrastructure[0].application_url : null
  ) : (
    var.cloud_provider == "gcp" ? module.gcp_infrastructure[0].application_url : null
  )
}

output "infrastructure_summary" {
  description = "Summary of deployed infrastructure"
  value = {
    project_name    = var.project_name
    environment     = var.environment
    cloud_provider  = var.cloud_provider
    region         = var.cloud_provider == "aws" ? var.aws_region : var.gcp_region
    application_url = var.cloud_provider == "aws" ? (
      length(module.aws_infrastructure) > 0 ? module.aws_infrastructure[0].application_url : null
    ) : (
      length(module.gcp_infrastructure) > 0 ? module.gcp_infrastructure[0].application_url : null
    )
  }
}
