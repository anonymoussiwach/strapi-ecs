resource "aws_ecs_cluster" "strapi" {
  name = "${var.app_name}-cluster"
}