
variable "vpc_id" {
  description = "VPC in which the ALB security group will be created"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

