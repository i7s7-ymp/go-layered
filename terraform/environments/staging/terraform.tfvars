# Staging Environment Configuration

project_name   = "go-layered"
environment    = "staging"
cloud_provider = "aws"  # Change to "gcp" to deploy on Google Cloud

# AWS Configuration
aws_region             = "us-west-2"
aws_availability_zones = ["us-west-2a", "us-west-2b"]

# GCP Configuration (used when cloud_provider = "gcp")
gcp_project_id = "your-gcp-project-id"
gcp_region     = "us-west2"

# Application Configuration
app_image         = "your-app:staging"  # Use staging image tag
app_port          = 8080
app_cpu           = "512"
app_memory        = "1024"
app_desired_count = 2  # AWS ECS
app_min_instances = 1  # GCP Cloud Run
app_max_instances = 10 # GCP Cloud Run

# Database Configuration
db_name               = "app_db_staging"
db_username           = "app_user"
db_instance_class     = "db.t3.small"    # AWS RDS
db_allocated_storage  = 50               # AWS RDS (GB)
gcp_db_tier          = "db-custom-1-3840" # GCP Cloud SQL

# Network Configuration
vpc_cidr             = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.11.0/24", "10.1.12.0/24"]

# Additional Configuration
domain_name         = "staging.your-domain.com"  # Optional
enable_ssl_redirect = true
