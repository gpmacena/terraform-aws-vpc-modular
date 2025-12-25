resource "aws_vpc" "project1" {
  cidr_block       = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-project1"
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.project1.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id                  = aws_vpc.project1.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az

  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "projeto1" {
  vpc_id = aws_vpc.project1.id

  tags = {
    Name = "ig-projeto1"
  }
}

resource "aws_route_table" "public" {
  
  vpc_id = aws_vpc.project1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.projeto1.id
  }

  tags = {
    Name = "route-table-public-projeto1"
  }
}

resource "aws_route_table" "private" {
  
  vpc_id = aws_vpc.project1.id

  tags = {
    Name = "route-table-private-projeto1"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = { Name = "nat-eip-projeto1" }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[keys(aws_subnet.public)[0]].id

  tags = { Name = "nat-gateway-projeto1" }

  depends_on = [aws_internet_gateway.projeto1]
}

resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}