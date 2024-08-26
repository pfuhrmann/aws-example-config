output "elb_id" {
  value       = aws_lb.main.id
  description = "The ID of the ELB"
}

output "elb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "The DNS associated with the ELB"
}

output "elb_target_group_arn" {
  value       = aws_lb_target_group.main.arn
  description = "The ARN of the ELB target group"
}

output "elb_security_group_name" {
  value       = aws_security_group.main.name
  description = "The name of the security group for the ELB"
}
