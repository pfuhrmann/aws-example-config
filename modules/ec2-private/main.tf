resource "aws_security_group" "main" {
  name   = "${var.name_prefix}-ec2"
  vpc_id = var.vpc_id
  description = "Allow HTTP traffic from ELB and all outbound traffic"

  ingress {
    description = "Allow HTTP requests from ELB"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    security_groups = [data.aws_security_group.elb.id]
  }

  tags = {
    Name        = "${var.name_prefix}-ec2"
    Environment = var.environment
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "main" {
  name_prefix   = "${var.name_prefix}-main"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  user_data = filebase64("${path.module}/run_server.sh")

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups = [aws_security_group.main.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.name_prefix}-main"
      Environment = var.environment
    }
  }
}

resource "aws_autoscaling_group" "main" {
  name = "${var.name_prefix}-main"

  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  target_group_arns = [var.elb_target_group_arn]
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    triggers = ["tag"]
  }

  tag {
    key                 = "launch version"
    value               = aws_launch_template.main.latest_version
    propagate_at_launch = true
  }

  depends_on = [var.elb_id]
}

resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.subdomain
  type    = "CNAME"
  ttl     = "300"
  records = [var.elb_dns_name]
}
