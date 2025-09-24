variable "docker_image" {
  description = "The ECR image URI for Strapi"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to deploy ECS in"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for Fargate service"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for ECS service"
  type        = string
}