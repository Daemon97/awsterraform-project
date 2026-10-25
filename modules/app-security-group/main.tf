
resource "aws_security_group" "app" {
  name        = "terraform-app-${var.environment}-sg"
  description = "Allow HTTP only from the ALB security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from the ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "terraform-app-${var.environment}-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "enterprise-terraform-aws"
  }
}

