ecs_service {
  cluster_name = aws_ecs_cluster.strapi_cluster.name
  service_name = aws_ecs_service.strapi_service.name
}