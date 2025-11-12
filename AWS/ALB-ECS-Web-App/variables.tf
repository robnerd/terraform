variable "region_primary" {
  description = "Main region for all resources"
  type        = string
}

variable "region_secondary" {
  description = "Secondary region for some resources for DR"
  type        = string
}
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the main VPC"
}

variable "public_subnet_1" {
  type        = string
  description = "CIDR block for public subnet 1"
}

variable "public_subnet_2" {
  type        = string
  description = "CIDR block for public subnet 2"
}


variable "private_subnet_1" {
  type        = string
  description = "CIDR block for private subnet 1"
}

variable "private_subnet_2" {
  type        = string
  description = "CIDR block for private subnet 2"
}

variable "availability_zone_1" {
  type        = string
  description = "First availibility zone"
}

variable "availability_zone_2" {
  type        = string
  description = "First availibility zone"
}

variable "default_tags" {
  type = map(any)
  default = {
    Application = "Demo App"
    Environment = "Dev"
  }
}

variable "container_port" {
  description = "Port that needs to be exposed for the application"
}

variable "shared_config_files" {
  description = "Path of your shared config file in .aws folder"
}

variable "shared_credentials_files" {
  description = "Path of your shared credentials file in .aws folder"
}

variable "credential_profile" {
  description = "Profile name in your credentials file"
  type        = string
}

variable "web_app_name" {
  description = "Name of your web app"
  type        = string
}

# Route 53 Variables
variable "create_dns_zone" {
  description = "If true, create new route53 zone, if false read existing route53 zone"
  type        = bool
  default     = false
}

variable "domain" {
  description = "Domain for website"
  type        = string
}

variable "environment_name" {
  description = "Deployment environment (dev/staging/production)"
  type        = string
  default     = "staging"
}
