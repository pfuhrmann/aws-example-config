variable "environment" {
  type        = string
  description = "Environment to deploy the infrastructure"
  nullable    = false
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
  nullable    = false
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the infrastructure"
  nullable    = false
}

variable "name_prefix" {
  type        = string
  description = "Prefix to use for the names of the resources"
  default     = "default"
}

variable "subdomain" {
  type        = string
  description = "Subdomain to use for the website"
  nullable    = false
}

variable "elb_id" {
  type        = string
  description = "ID of the Elastic Load Balancer"
  nullable    = false
}

variable "elb_dns_name" {
  type        = string
  description = "DNS name of the Elastic Load Balancer"
  nullable    = false
}

variable "elb_target_group_arn" {
  type        = string
  description = "ARN of the Elastic Load Balancer target group"
  nullable    = false
}

variable "elb_security_group_name" {
  type        = string
  description = "Name of the security group for the Elastic Load Balancer"
  nullable    = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to associate with EC2 instances"
  default     = []
}

variable "desired_capacity" {
  type        = number
  description = "Number of instances to run"
  default     = 2
}

variable "max_size" {
  type        = number
  description = "Maximum number of instances to run"
  default     = 5
}

variable "min_size" {
  type        = number
  description = "Minimum number of instances to run"
  default     = 2
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to run"
  default     = "t2.micro"
}

variable "hosted_zone_name" {
  type        = string
  description = "Name of the hosted zone"
  nullable    = false
}
