variable "ami_id" {
  description = "Ubuntu AMI ID for the application servers"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "app_security_group_id" {
  description = "Security group allowing HTTP only from the ALB"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
