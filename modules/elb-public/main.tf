resource "aws_security_group" "main" {
  name   = "${var.name_prefix}-elb"
  vpc_id = var.vpc_id
  description = "Allow HTTP traffic from anywhere and all outbound traffic"

  ingress {
    description = "Allow HTTP request from anywhere"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.name_prefix}-elb"
    Environment = var.environment
  }
}

resource "aws_lb" "main" {
  name               = "${var.name_prefix}-main"
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.main.id]
  subnets            = var.subnet_ids

  tags = {
    Name        = "${var.name_prefix}-main"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.name_prefix}-main"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  tags = {
    Name        = "${var.name_prefix}-main"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.name_prefix}-main"
    Environment = var.environment
  }
}

resource "aws_route_table" "main" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.name_prefix}-lb"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "main" {
  count = length(var.subnet_ids)

  subnet_id      = element(var.subnet_ids, count.index)
  route_table_id = aws_route_table.main.id
}

