#################################################################################################
# This file describes the IAM resources: ECS task role, ECS execution role
#################################################################################################


resource "aws_iam_role" "ecsTaskExecutionRole" {
  #count              = data.aws_region.current.region == "us-east-2" ? 1 : 0 #create resource unless in DR environment
  name               = "${var.web_app_name}-app-ecsTaskExecutionRole-${data.aws_region.current.region}-${var.environment_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs-task-role" {
  name = "ecs-task-role-custom-${data.aws_region.current.region}-${var.environment_name}"

  # This role is assigned to task in the ecs task definition 
  # The corresponding polices allow:
  #   -Full DynamoDB access
  #   -Execution into containers for troubleshooting
  # Attached and inline policies below assigned to this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecsTaskRole_policy" {
  role       = aws_iam_role.ecs-task-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy" "ecs-task-policy" {
  name = "ecs-task-policy-inline-${data.aws_region.current.region}-${var.environment_name}"
  role = aws_iam_role.ecs-task-role.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:DescribeLogGroups"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })
}





