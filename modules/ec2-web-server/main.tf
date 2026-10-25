
resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail

    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y nginx

    cat > /var/www/html/index.html <<'HTML'
    <!doctype html>
    <html>
      <head><title>Terraform Demo s3</title></head>
      <body>
        <h1>Application deployed with Terraform</h1>
        <p>Environment: Development</p>
        <p>Web server: Nginx on Ubuntu</p>
      </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl restart nginx
  EOF

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    volume_size = 8
  }

  tags = {
    Name        = "terraform-app-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "enterprise-terraform-aws"
  }
}

