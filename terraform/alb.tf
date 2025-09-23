resource "aws_lb" "strapi" {
  name               = "${var.app_name}-alb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.strapi_sg.id]
}

resource "aws_lb_target_group" "strapi" {
  name     = "${var.app_name}-tg"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
  target_type = "ip"
}

resource "aws_lb_listener" "strapi" {
  load_balancer_arn = aws_lb.strapi.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.strapi.arn
  }
}