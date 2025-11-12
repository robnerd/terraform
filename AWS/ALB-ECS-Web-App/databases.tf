#################################################################################################
# This file describes the DynamoDB resources: dynamodb table, dynamodb endpoint
#################################################################################################

#Dynamodb Table
resource "aws_dynamodb_table" "global_days_table" {
  count            = data.aws_region.current.region == "us-east-2" ? 1 : 0 #create resource unless in DR environment
  provider         = aws.primary
  name             = "leavedays-${var.environment_name}"
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "leave_id"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  attribute {
    name = "leave_id"
    type = "N"
  }
  # Enable point-in-time recovery
  point_in_time_recovery {
    enabled = true
  }

  # Server-side encryption
  server_side_encryption {
    enabled = true
  }

  # Global table replica configuration
  replica {
    region_name            = var.region_secondary
    point_in_time_recovery = true
  }
  tags = {
    Name        = "dynamodb-table"
    Environment = var.environment_name
  }
}

resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.${data.aws_region.current.region}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id]
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
  tags = {
    Name = "dynamodb-vpc-endpoint-${data.aws_region.current.region}-${var.environment_name}"
  }
}
