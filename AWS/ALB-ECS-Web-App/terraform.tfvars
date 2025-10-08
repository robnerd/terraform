#These are the only value that need to be changed on implementation
region                   = "us-east-2"
vpc_cidr                 = "10.0.0.0/16"
public_subnet_1          = "10.0.16.0/20"
public_subnet_2          = "10.0.32.0/20"
private_subnet_1         = "10.0.80.0/20"
private_subnet_2         = "10.0.112.0/20"
availability_zone_1      = "us-east-2a"
availability_zone_2      = "us-east-2b"
container_port           = 8081
shared_config_files      = "" # Replace with path
shared_credentials_files = "" # Replace with path
credential_profile       = "" # Replace with what you named your profile
web_app_name             = "hotel-booking-app"
