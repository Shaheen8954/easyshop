#!/bin/bash

echo "Starting Terraform destroy process..."

# First try normal destroy
terraform destroy -auto-approve

# If that fails, try to delete EKS cluster manually first
if [ $? -ne 0 ]; then
    echo "Normal destroy failed. Attempting manual cleanup..."
    
    # Delete EKS cluster
    aws eks delete-cluster --name easyshop-cluster --region eu-west-1
    
    # Wait for cluster deletion
    echo "Waiting for cluster deletion..."
    aws eks wait cluster-deleted --name easyshop-cluster --region eu-west-1
    
    # Try destroy again
    terraform destroy -auto-approve
fi

echo "Cleanup complete!"
