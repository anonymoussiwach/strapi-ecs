variable "vite_allowed_hosts" {
  type = string
  description = "Allowed host for Vite/Strapi frontend"
}

variable "docker_image" {
  description = "Docker image URI in ECR"
  type        = string
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of existing subnet IDs for ECS service"
  type        = list(string)
}

variable "ecs_execution_role_arn" {
  description = "Existing ECS task execution role ARN"
  type        = string
}

variable "cluster_name" {
  description = "Name of ECS cluster"
  type        = string
  default     = "strapi-cluster"
}

variable "service_name" {
  description = "Name of ECS service"
  type        = string
  default     = "strapi-service"
}