output "ecs_cluster_id" {
  value = aws_ecs_cluster.strapi_cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.strapi_service.name
}

output "security_group_id" {
  value = var.security_group_id
}