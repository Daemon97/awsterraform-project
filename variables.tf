variable "aws_region" {
  description = "AWS region for the project"
  type        = string
  default     = "ap-south-2"
}

variable "ami_id" {
  description = "Ubuntu AMI ID in the selected AWS region"
  type        = string
  default     = "ami-0ef8e8e484bc9df23"
}

variable "instance_type" {
  description = "EC2 instance type for the learning lab"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Existing subnet where the EC2 will be launched"
  type        = string
  default     = "subnet-0ee97ffd61a831ea7"
}

variable "security_group_id" {
  description = "Existing default security group"
  type        = string
  default     = "sg-0841177b237f7083a"
}
