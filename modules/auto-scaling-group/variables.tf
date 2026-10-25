
variable "launch_template_id" {
  description = "ID of the application Launch Template"
  type        = string
}

variable "public_subnet_ids" {
  description = "Subnet IDs where the ASG will launch instances"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "desired_capacity" {
  description = "Desired number of application instances"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of application instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of application instances"
  type        = number
  default     = 3
}

