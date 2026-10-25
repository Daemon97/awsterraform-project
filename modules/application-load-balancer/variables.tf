
variable "vpc_id" {
  description = "VPC where the load balancer and target group will operate"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs across at least two Availability Zones"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group attached to the load balancer"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

