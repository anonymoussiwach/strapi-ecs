variable "docker_image" {
  description = "ECR image to use for Strapi"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for ECS service"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for ECS Fargate service"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for ECS service"
  type        = string
}

variable "key_pair" {
  description = "EC2 Key Pair (if needed for any tasks)"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of ECS Cluster"
  type        = string
  default     = "strapi-cluster"
}