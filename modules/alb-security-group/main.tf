
resource "aws_security_group" "alb" {
  name        = "terraform-alb-${var.environment}"
  description = "Allow HTTP traffic to the application load balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "terraform-alb-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "enterprise-terraform-aws"
  }
}

