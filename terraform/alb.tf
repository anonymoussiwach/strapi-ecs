# Application Load Balancer
resource "aws_lb" "strapi_alb" {
  name               = "strapi-alb-mayank"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    "subnet-065f226753ec5fd8f",
    "subnet-06d7c618847e312a3"
  ]
}

# Blue Target Group
resource "aws_lb_target_group" "strapi_tg_blue" {
  name        = "strapi-tg-blue-mayank"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = "vpc-0afe9dc99028a85ee"
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Green Target Group
resource "aws_lb_target_group" "strapi_tg_green" {
  name        = "strapi-tg-green-mayank"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = "vpc-0afe9dc99028a85ee"
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Listener (initially forwards to Blue)
resource "aws_lb_listener" "strapi_listener" {
  load_balancer_arn = aws_lb.strapi_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.strapi_tg_blue.arn
  }
}