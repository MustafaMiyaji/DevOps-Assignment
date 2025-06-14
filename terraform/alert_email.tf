# CloudWatch Dashboard and Alarm Setup

# Create a CloudWatch dashboard
resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "devops-assignment-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ClusterName", var.project_name, { "stat": "Average" }],
            ["AWS/ECS", "MemoryUtilization", "ClusterName", var.project_name, { "stat": "Average" }]
          ],
          view        = "timeSeries",
          stacked     = false,
          region      = var.aws_region,
          title       = "ECS Cluster CPU & Memory Utilization"
        }
      }
    ]
  })
}

# SNS topic for sending alerts
resource "aws_sns_topic" "alerts" {
  name = "devops-cpu-alerts"
}

# Subscribe to the SNS topic (email)
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email  # Add this var to terraform.tfvars
}

# CloudWatch alarm for ECS CPU usage
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name          = "ecs-high-cpu-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 70
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  alarm_description   = "This alarm triggers if average ECS CPU usage > 70% for 5 mins"
  dimensions = {
    ClusterName = var.project_name
    ServiceName = "devops-assignment-backend-service"
  }
  alarm_actions = [aws_sns_topic.alerts.arn]
}

variable "alert_email" {
  description = "Email address for receiving CPU alarms"
  type        = string
}
