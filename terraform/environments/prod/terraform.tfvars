# Production Environment Configuration

project_name   = "go-layered"
environment    = "prod"
cloud_provider = "aws"  # Change to "gcp" to deploy on Google Cloud

# AWS Configuration
aws_region             = "us-west-2"
aws_availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

# GCP Configuration (used when cloud_provider = "gcp")
gcp_project_id = "your-gcp-project-id"
gcp_region     = "us-west2"

# Application Configuration
app_image         = "your-app:latest"  # Use production image tag
app_port          = 8080
app_cpu           = "1024"
app_memory        = "2048"
app_desired_count = 3   # AWS ECS
app_min_instances = 2   # GCP Cloud Run
app_max_instances = 50  # GCP Cloud Run

# Database Configuration
db_name               = "app_db_prod"
db_username           = "app_user"
db_instance_class     = "db.t3.medium"     # AWS RDS
db_allocated_storage  = 100               # AWS RDS (GB)
gcp_db_tier          = "db-custom-2-7680" # GCP Cloud SQL

# Network Configuration
vpc_cidr             = "10.2.0.0/16"
public_subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
private_subnet_cidrs = ["10.2.11.0/24", "10.2.12.0/24", "10.2.13.0/24"]

# Additional Configuration
domain_name         = "your-domain.com"  # Your production domain
enable_ssl_redirect = true
