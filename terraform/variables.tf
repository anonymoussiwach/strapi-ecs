variable "docker_image" {
  description = "ECR image for Strapi"
  type        = string
}

variable "key_pair" {
  description = "EC2 Key Pair name for SSH (if needed)"
  type        = string
}

variable "security_group_id" {
  description = "Existing Security Group ID for ECS service"
  type        = string
  default     = "sg-0fc419b83ffd83dd6"
}

variable "vpc_id" {
  description = "VPC ID for ECS tasks"
  type        = string
  default     = "vpc-098cc44dc4ec933d7"
}

variable "subnet_ids" {
  description = "List of Subnet IDs for ECS tasks"
  type        = list(string)
  default     = ["subnet-08f7b9dfa8bd5c307"]
}