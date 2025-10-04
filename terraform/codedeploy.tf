# ===========================
# Fetch existing CodeDeploy Role
# ===========================
data "aws_iam_role" "codedeploy_role" {
  name = "codedeploy-role-mayank"
}

# ===========================
# CodeDeploy ECS Application
# ===========================
resource "aws_codedeploy_app" "strapi_app" {
  name             = "strapi-app-mayank"
  compute_platform = "ECS"
}

# ===========================
# CodeDeploy Deployment Group
# ===========================
resource "aws_codedeploy_deployment_group" "strapi_deploy_group" {
  app_name              = aws_codedeploy_app.strapi_app.name
  deployment_group_name = "strapi-deploy-group-mayank"
  service_role_arn      = data.aws_iam_role.codedeploy_role.arn

  deployment_config_name = "CodeDeployDefault.ECSCanary10Percent5Minutes"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action                          = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.strapi_cluster.name
    service_name = aws_ecs_service.strapi_service.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [aws_lb_listener.strapi_listener.arn]
      }
      target_group {
        name = aws_lb_target_group.strapi_tg_blue.name
      }
      target_group {
        name = aws_lb_target_group.strapi_tg_green.name
      }
    }
  }
}

# ===========================
# ECS Service (Blue/Green)
# ===========================
resource "aws_ecs_service" "strapi_service" {
  name            = "strapi-service-mayank"
  cluster         = aws_ecs_cluster.strapi_cluster.id
  task_definition = aws_ecs_task_definition.strapi_task.arn
  desired_count   = 1

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.strapi_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.strapi_tg_blue.arn
    container_name   = "strapi"
    container_port   = 1337
  }

  depends_on = [aws_lb_listener.strapi_listener]
}