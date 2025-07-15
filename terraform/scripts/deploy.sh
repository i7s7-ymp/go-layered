#!/bin/bash

# Terraform Deployment Script
# This script automates the deployment process for the Go layered application

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
ENVIRONMENT="dev"
CLOUD_PROVIDER=""
ACTION="plan"
AUTO_APPROVE=false

# Function to print colored output
print_colored() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to print usage
usage() {
    print_colored $BLUE "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -e, --environment    Environment (dev, staging, prod) [default: dev]"
    echo "  -p, --provider       Cloud provider (aws, gcp)"
    echo "  -a, --action         Action (plan, apply, destroy) [default: plan]"
    echo "  -y, --auto-approve   Skip confirmation prompts"
    echo "  -h, --help          Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -e dev -p aws -a plan"
    echo "  $0 -e prod -p gcp -a apply -y"
    echo "  $0 -e staging -p aws -a destroy"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--environment)
            ENVIRONMENT="$2"
            shift 2
            ;;
        -p|--provider)
            CLOUD_PROVIDER="$2"
            shift 2
            ;;
        -a|--action)
            ACTION="$2"
            shift 2
            ;;
        -y|--auto-approve)
            AUTO_APPROVE=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            print_colored $RED "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Validate environment
if [[ ! "$ENVIRONMENT" =~ ^(dev|staging|prod)$ ]]; then
    print_colored $RED "Error: Environment must be one of: dev, staging, prod"
    exit 1
fi

# Validate cloud provider
if [[ -z "$CLOUD_PROVIDER" ]]; then
    print_colored $RED "Error: Cloud provider must be specified (aws or gcp)"
    usage
    exit 1
fi

if [[ ! "$CLOUD_PROVIDER" =~ ^(aws|gcp)$ ]]; then
    print_colored $RED "Error: Cloud provider must be either 'aws' or 'gcp'"
    exit 1
fi

# Validate action
if [[ ! "$ACTION" =~ ^(plan|apply|destroy)$ ]]; then
    print_colored $RED "Error: Action must be one of: plan, apply, destroy"
    exit 1
fi

# Set environment directory
ENV_DIR="terraform/environments/$ENVIRONMENT"

# Check if environment directory exists
if [[ ! -d "$ENV_DIR" ]]; then
    print_colored $RED "Error: Environment directory $ENV_DIR does not exist"
    exit 1
fi

# Function to check prerequisites
check_prerequisites() {
    print_colored $BLUE "Checking prerequisites..."
    
    # Check if Terraform is installed
    if ! command -v terraform &> /dev/null; then
        print_colored $RED "Error: Terraform is not installed"
        exit 1
    fi
    
    # Check Terraform version
    TERRAFORM_VERSION=$(terraform version -json | jq -r '.terraform_version')
    print_colored $GREEN "✓ Terraform version: $TERRAFORM_VERSION"
    
    # Check cloud provider CLI
    if [[ "$CLOUD_PROVIDER" == "aws" ]]; then
        if ! command -v aws &> /dev/null; then
            print_colored $RED "Error: AWS CLI is not installed"
            exit 1
        fi
        
        # Check AWS credentials
        if ! aws sts get-caller-identity &> /dev/null; then
            print_colored $RED "Error: AWS credentials not configured"
            exit 1
        fi
        
        AWS_ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
        AWS_USER=$(aws sts get-caller-identity --query UserId --output text)
        print_colored $GREEN "✓ AWS Account: $AWS_ACCOUNT"
        print_colored $GREEN "✓ AWS User: $AWS_USER"
        
    elif [[ "$CLOUD_PROVIDER" == "gcp" ]]; then
        if ! command -v gcloud &> /dev/null; then
            print_colored $RED "Error: gcloud CLI is not installed"
            exit 1
        fi
        
        # Check GCP authentication
        if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | head -n1 &> /dev/null; then
            print_colored $RED "Error: GCP authentication not configured"
            exit 1
        fi
        
        GCP_PROJECT=$(gcloud config get-value project 2>/dev/null || echo "Not set")
        GCP_ACCOUNT=$(gcloud auth list --filter=status:ACTIVE --format="value(account)" | head -n1)
        print_colored $GREEN "✓ GCP Project: $GCP_PROJECT"
        print_colored $GREEN "✓ GCP Account: $GCP_ACCOUNT"
    fi
}

# Function to initialize Terraform
terraform_init() {
    print_colored $BLUE "Initializing Terraform..."
    cd "$ENV_DIR"
    terraform init
    cd - > /dev/null
}

# Function to validate Terraform configuration
terraform_validate() {
    print_colored $BLUE "Validating Terraform configuration..."
    cd "$ENV_DIR"
    terraform validate
    cd - > /dev/null
    print_colored $GREEN "✓ Configuration is valid"
}

# Function to run Terraform plan
terraform_plan() {
    print_colored $BLUE "Running Terraform plan..."
    cd "$ENV_DIR"
    terraform plan -var="cloud_provider=$CLOUD_PROVIDER"
    cd - > /dev/null
}

# Function to run Terraform apply
terraform_apply() {
    print_colored $BLUE "Running Terraform apply..."
    cd "$ENV_DIR"
    
    if [[ "$AUTO_APPROVE" == "true" ]]; then
        terraform apply -var="cloud_provider=$CLOUD_PROVIDER" -auto-approve
    else
        terraform apply -var="cloud_provider=$CLOUD_PROVIDER"
    fi
    
    cd - > /dev/null
    print_colored $GREEN "✓ Infrastructure deployed successfully"
}

# Function to run Terraform destroy
terraform_destroy() {
    print_colored $YELLOW "⚠️  This will destroy all infrastructure in $ENVIRONMENT environment!"
    
    if [[ "$AUTO_APPROVE" != "true" ]]; then
        read -p "Are you sure you want to continue? (yes/no): " -r
        if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
            print_colored $BLUE "Operation cancelled"
            exit 0
        fi
    fi
    
    print_colored $BLUE "Running Terraform destroy..."
    cd "$ENV_DIR"
    
    if [[ "$AUTO_APPROVE" == "true" ]]; then
        terraform destroy -var="cloud_provider=$CLOUD_PROVIDER" -auto-approve
    else
        terraform destroy -var="cloud_provider=$CLOUD_PROVIDER"
    fi
    
    cd - > /dev/null
    print_colored $GREEN "✓ Infrastructure destroyed successfully"
}

# Function to show outputs
show_outputs() {
    print_colored $BLUE "Infrastructure outputs:"
    cd "$ENV_DIR"
    terraform output
    cd - > /dev/null
}

# Main execution
main() {
    print_colored $BLUE "================================================"
    print_colored $BLUE "Go Layered Application - Terraform Deployment"
    print_colored $BLUE "================================================"
    echo ""
    print_colored $BLUE "Environment: $ENVIRONMENT"
    print_colored $BLUE "Cloud Provider: $CLOUD_PROVIDER"
    print_colored $BLUE "Action: $ACTION"
    echo ""
    
    check_prerequisites
    terraform_init
    terraform_validate
    
    case $ACTION in
        plan)
            terraform_plan
            ;;
        apply)
            terraform_apply
            show_outputs
            ;;
        destroy)
            terraform_destroy
            ;;
    esac
    
    print_colored $GREEN "Operation completed successfully!"
}

# Run main function
main
