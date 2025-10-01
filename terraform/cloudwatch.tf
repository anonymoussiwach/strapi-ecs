# CloudWatch for Strapi ECS

# Log Group for ECS Task Logs
resource "aws_cloudwatch_log_group" "strapi_logs" {
  name              = "/ecs/strapi/mayank"
  retention_in_days = 7
}

# CPU Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name          = "strapi-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "ECS Service CPU > 80%"
  alarm_actions       = [aws_sns_topic.strapi_alerts.arn]
  dimensions = {
    ClusterName = aws_ecs_cluster.strapi_cluster.name
    ServiceName = aws_ecs_service.strapi_service.name
  }
}

# Memory Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {
  alarm_name          = "strapi-memory-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "ECS Service Memory > 80%"
  alarm_actions       = [aws_sns_topic.strapi_alerts.arn]
  dimensions = {
    ClusterName = aws_ecs_cluster.strapi_cluster.name
    ServiceName = aws_ecs_service.strapi_service.name
  }
}

# Dashboard for ECS Service Monitoring
resource "aws_cloudwatch_dashboard" "strapi_dashboard" {
  dashboard_name = "Strapi-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x    = 0
        y    = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [ "AWS/ECS", "CPUUtilization", "ClusterName", aws_ecs_cluster.strapi_cluster.name, "ServiceName", aws_ecs_service.strapi_service.name ],
            [ ".", "MemoryUtilization", ".", ".", ".", "." ]
          ]
          period = 60
          stat   = "Average"
          region = "ap-south-1"
          title  = "ECS CPU & Memory Utilization"
        }
      }
    ]
  })
}