# AWS-ALB-ECS

This provides a staging environment to be used with the ALB-ECS-Web-App module

Templates for ECS serverless (Fargate) and ALB with docker deployment for a web app

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
