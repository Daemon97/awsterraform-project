
variable "vpc_id" {
  description = "VPC in which the application security group will be created"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group allowed to access the application servers"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

