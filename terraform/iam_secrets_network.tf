# IAM role for ECS tasks
# Attach permissions for ECR, CloudWatch, and Secrets Manager
resource "aws_iam_role_policy" "ecs_custom_policy" {
  name = "${var.project_name}-ecs-custom-policy"
  role = aws_iam_role.ecs_task_execution.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "AllowLogs",
        Effect: "Allow",
        Action: [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource: "*"
      },
      {
        Sid: "AllowECRPull",
        Effect: "Allow",
        Action: [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource: "*"
      },
      {
        Sid: "AllowSecretsAccess",
        Effect: "Allow",
        Action: [
          "secretsmanager:GetSecretValue"
        ],
        Resource: aws_secretsmanager_secret.backend_credentials.arn
      }
    ]
  })
}

# Secrets Manager for OpenAI key
resource "aws_secretsmanager_secret" "backend_credentials" {
  name = "${var.project_name}/backend/api_key"
}

resource "aws_secretsmanager_secret_version" "backend_credentials_value" {
  secret_id     = aws_secretsmanager_secret.backend_credentials.id
  secret_string = jsonencode({
    api_key = var.backend_api_key
  })
}

# Variable for backend secret
variable "backend_api_key" {
  description = "Sensitive API key for backend"
  type        = string
}
