terraform {

  required_version = "~> 1.13.1"
  #required_version = ">= 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 5.1.0"
      version = "~> 6.18.0"
    }
  }
}


provider "aws" {
  alias  = "primary"
  region = "us-east-2" #default region for production environment
}

data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

locals {
  environment_name = "production"
  vpc_cidr         = "10.0.0.0/16"
  azs              = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]

}

module "ALB-ECS-Web-App" {
  source = "../ALB-ECS-Web-App"

  #input variables
  domain                   = "unitedautobots.com"
  create_dns_zone          = "false"
  region_primary           = "us-east-2"
  region_secondary         = "us-east-1"
  environment_name         = local.environment_name
  vpc_cidr                 = local.vpc_cidr
  public_subnet_1          = local.public_subnets[0]
  public_subnet_2          = local.public_subnets[1]
  private_subnet_1         = local.private_subnets[0]
  private_subnet_2         = local.private_subnets[1]
  availability_zone_1      = local.azs[0]
  availability_zone_2      = local.azs[1]
  container_port           = 8081
  shared_config_files      = "" # Replace with path
  shared_credentials_files = "" # Replace with path
  credential_profile       = "" # Replace with what you named your profile
  web_app_name             = "hotel-booking-app"
}


