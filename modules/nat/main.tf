resource "aws_eip" "main" {
  domain = "vpc"
  tags = {
    Name        = "${var.name_prefix}-main"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name        = "${var.name_prefix}-main"
    Environment = var.environment
  }
}

resource "aws_route_table" "main" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name        = "${var.name_prefix}-nat"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private_main" {
  count = length(var.private_subnet_ids)

  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.main.id
}
