output "PUBLIC_ALB_ARN" {
  value = aws_lb.public.arn
}

output "PRIVATE_ALB_ARN" {
  value = aws_lb.private.arn
}