resource "aws_vpc" "primary" {
  provider = aws.primary
  cidr_block = var.vpc_cidr
  tags = { Name = "primary-vpc" }
}

resource "aws_subnet" "primary_public" {
  provider = aws.primary
  vpc_id = aws_vpc.primary.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.primary_region}a"
  tags = { Name = "primary-public" }
}

resource "aws_subnet" "primary_private" {
  provider = aws.primary
  vpc_id = aws_vpc.primary.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.primary_region}a"
  tags = { Name = "primary-private" }
}

resource "aws_eip" "primary_nat" {
  provider = aws.primary
}

resource "aws_nat_gateway" "primary" {
  provider = aws.primary
  allocation_id = aws_eip.primary_nat.id
  subnet_id = aws_subnet.primary_public.id
  tags = { Name = "primary-nat" }
}

resource "aws_vpc" "secondary" {
  provider = aws.secondary
  cidr_block = var.vpc_cidr
  tags = { Name = "secondary-vpc" }
}

resource "aws_subnet" "secondary_public" {
  provider = aws.secondary
  vpc_id = aws_vpc.secondary.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.secondary_region}a"
  tags = { Name = "secondary-public" }
}

resource "aws_subnet" "secondary_private" {
  provider = aws.secondary
  vpc_id = aws_vpc.secondary.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "${var.secondary_region}a"
  tags = { Name = "secondary-private" }
}

resource "aws_eip" "secondary_nat" {
  provider = aws.secondary
}

resource "aws_nat_gateway" "secondary" {
  provider = aws.secondary
  allocation_id = aws_eip.secondary_nat.id
  subnet_id = aws_subnet.secondary_public.id
  tags = { Name = "secondary-nat" }
}

resource "aws_vpc_peering_connection" "interregion" {
  provider = aws.primary
  vpc_id        = aws_vpc.primary.id
  peer_vpc_id   = aws_vpc.secondary.id
  peer_region   = var.secondary_region
  auto_accept   = true
  tags = { Name = "interregion-peering" }
}
