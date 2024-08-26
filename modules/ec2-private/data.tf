data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-2*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_route53_zone" "main" {
  name = var.hosted_zone_name
}

data "aws_security_group" "elb" {
  name = var.elb_security_group_name

  depends_on = [var.elb_id]
}
