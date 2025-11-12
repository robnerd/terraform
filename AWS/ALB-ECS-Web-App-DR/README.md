# AWS-ALB-ECS-DR

This is a active-passive disaster recovery template to bring up resources in a secondary region in the event an outage occurs in the primary region

Requirements:

1. An AWS account with appropriate access (ECS, ECR, DynamoDB)
2. Docker installed and running on your machine.
3. Terraform installed on your machine
4. AWS CLI Installed

Steps to use:

1. Clone the repo to your desired location
2. Edit the terraform.tfvars file with your desired values
3. Run "terraform init", "terraform plan" and "terraform apply"

Terraform destroy does not delete the ECR repo and Task definition
