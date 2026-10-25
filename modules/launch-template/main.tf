resource "aws_launch_template" "app" {
  name_prefix   = "terraform-app-${var.environment}-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.app_security_group_id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    set -eux

    apt-get update -y
    apt-get install -y nginx

    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
      <head>
        <title>Terraform Auto Scaling Demo</title>
      </head>
      <body>
        <h1>Application deployed with Terraform</h1>
        <p>Environment: Development</p>
        <p>Managed by: Auto Scaling Group</p>
      </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl restart nginx
  EOF
  )

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "terraform-asg-app-${var.environment}"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "enterprise-terraform-aws"
    }
  }

  tags = {
    Name        = "terraform-launch-template-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "enterprise-terraform-aws"
  }
}
