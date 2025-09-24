output "ecs_cluster_id" {
  value = aws_ecs_cluster.strapi_cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.strapi_service.name
}

output "strapi_url" {
  value = aws_lb.strapi_alb.dns_name
}