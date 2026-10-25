
data "aws_vpc" "existing" {
  id = "vpc-0c3802735c9e155ef"
}

# Reusable security group module
module "web_security_group" {
  source = "./modules/web-security-group"

  vpc_id = data.aws_vpc.existing.id
}

# Security group for the Application Load Balancer
module "alb_security_group" {
  source = "./modules/alb-security-group"

  vpc_id      = data.aws_vpc.existing.id
  environment = "dev"
}

# Security group for the new application servers
module "app_security_group" {
  source = "./modules/app-security-group"

  vpc_id                = data.aws_vpc.existing.id
  alb_security_group_id = module.alb_security_group.security_group_id
  environment           = "dev"
}

# Reusable EC2 web server module
module "ec2_web_server" {
  source = "./modules/ec2-web-server"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = var.subnet_id
  security_group_id = module.web_security_group.security_group_id
  environment       = "dev"
}

# Preserve the existing security group
moved {
  from = aws_security_group.web
  to   = module.web_security_group.aws_security_group.web
}

# Preserve the existing EC2 instance
moved {
  from = aws_instance.app
  to   = module.ec2_web_server.aws_instance.app
}

# Root outputs
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_web_server.instance_id
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.ec2_web_server.private_ip
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2_web_server.public_ip
}

output "website_url" {
  description = "URL of the Nginx website"
  value       = module.ec2_web_server.website_url
}
module "application_load_balancer" {
  source = "./modules/application-load-balancer"

  vpc_id = data.aws_vpc.existing.id

  public_subnet_ids = [
    "subnet-0ee97ffd61a831ea7",
    "subnet-05bb22cd941032545"
  ]

  alb_security_group_id = module.alb_security_group.security_group_id
  environment           = "dev"
}
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.application_load_balancer.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.application_load_balancer.alb_arn
}

output "target_group_arn" {
  description = "ARN of the application target group"
  value       = module.application_load_balancer.target_group_arn
}

module "launch_template" {
  source = "./modules/launch-template"

  ami_id                = var.ami_id
  instance_type         = var.instance_type
  app_security_group_id = module.app_security_group.security_group_id
  environment           = "dev"
}

module "auto_scaling_group" {
  source = "./modules/auto-scaling-group"

  launch_template_id = module.launch_template.launch_template_id

  public_subnet_ids = [
    "subnet-0ee97ffd61a831ea7",
    "subnet-05bb22cd941032545"
  ]

  target_group_arn = module.application_load_balancer.target_group_arn

  environment      = "dev"
  desired_capacity = 2
  min_size         = 2
  max_size         = 3
}

