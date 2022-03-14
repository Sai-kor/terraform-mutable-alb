resource "aws_lb" "public" {
  name               = "${var.ENV}-public-alb"
  internal           = false //it means public load balancer
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_lb.id]
  subnets            = data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNETS
  // this is a list and expecting one is also a list

  tags = {
    Environment = "${var.ENV}-public-alb"
  }
}

resource "aws_lb" "private" {
  name               = "${var.ENV}-private-alb"
  internal           = false //it means public load balancer
  load_balancer_type = "application"
  security_groups    = [aws_security_group.private_lb.id]
  subnets            = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS

  tags = {
    Environment = "${var.ENV}-private-alb"
  }
}

resource "aws_lb_listener" "private" {
  load_balancer_arn = aws_lb.private.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "ok"
      status_code  = "200"
    }
  }
}
