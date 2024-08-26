output "nat_public_ip" {
  value       = aws_eip.main.public_ip
  description = "The public IP of the NAT gateway"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.main.id
  description = "The ID of the NAT gateway"
}
