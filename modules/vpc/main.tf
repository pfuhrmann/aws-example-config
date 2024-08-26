resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name        = "${var.name_prefix}-main"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}${element(["a", "b", "c"], count.index)}"

  tags = {
    Name        = "${var.name_prefix}-public-${element(["a", "b", "c"], count.index)}"
    Environment = var.environment
  }
}


resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = false
  availability_zone       = "${var.aws_region}${element(["a", "b", "c"], count.index)}"

  tags = {
    Name        = "${var.name_prefix}-private-${element(["a", "b", "c"], count.index)}"
    Environment = var.environment
  }
}
