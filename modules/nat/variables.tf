variable "environment" {
  type        = string
  description = "Environment to deploy the infrastructure"
  nullable    = false
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC in which to deploy the NAT gateway"
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

variable "private_subnet_ids" {
    type        = list(string)
    description = "List of private subnet IDs in which to attach the NAT gateway"
    default     = []
  }

variable "public_subnet_id" {
  type        = string
  description = "ID of the public subnet in which to deploy the NAT gateway"
  nullable    = false
}
