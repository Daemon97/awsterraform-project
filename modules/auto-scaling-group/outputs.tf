
output "autoscaling_group_name" {
  description = "Name of the application Auto Scaling Group"
  value       = aws_autoscaling_group.app.name
}

output "autoscaling_group_arn" {
  description = "ARN of the application Auto Scaling Group"
  value       = aws_autoscaling_group.app.arn
}

