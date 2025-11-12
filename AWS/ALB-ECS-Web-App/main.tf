terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 5.1.0"
      version = "~> 6.18.0"
    }
  }
}

provider "aws" {
  #this provider region is hardcoded in "aws_dynamodb_table and "aws_vpc_endpoint"
  alias  = "primary"
  region = "us-east-2"
}

/*
provider "aws" {
  alias  = "secondary"
  region = "us-east-1" #secondary region for DR
}

# the below is required in order to reference in databases.tf
data "aws_region" "current" {}


data "aws_region" "alternate" {
  provider = "awsalternate"
}
*/

