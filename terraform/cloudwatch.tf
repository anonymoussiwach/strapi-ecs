# CloudWatch Log Group for Strapi
resource "aws_cloudwatch_log_group" "strapi_logs" {
  name              = "/ecs/strapi/mayank"
  retention_in_days = 7
}