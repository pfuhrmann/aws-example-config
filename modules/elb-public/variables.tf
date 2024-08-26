variable "environment" {
  type        = string
  description = "Environment to deploy the infrastructure"
  nullable    = false
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC in which to deploy the ELB"
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

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to associate with the ELB"
  default     = []
}
