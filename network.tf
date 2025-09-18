# resource "aws_vpc" "primary" {
#   provider   = aws.primary
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "primary-vpc"
#   }
# }

# resource "aws_subnet" "primary_private_a" {
#   provider          = aws.primary
#   vpc_id            = aws_vpc.primary.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "${var.primary_region}a"
#   tags = {
#     Name = "primary-private-a"
#   }
# }

# resource "aws_subnet" "primary_private_b" {
#   provider          = aws.primary
#   vpc_id            = aws_vpc.primary.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "${var.primary_region}b"
#   tags = {
#     Name = "primary-private-b"
#   }
# }

esource "aws_vpc" "secondary" {
  provider = aws.secondary
  cidr_block = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "secondary-vpc"
  }
}

resource "aws_subnet" "private_a" {
  provider = aws.secondary
  vpc_id            = aws_vpc.secondary.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = false

  tags = { Name = "secondary-private-a" }
}

resource "aws_subnet" "private_b" {
  provider = aws.secondary
  vpc_id            = aws_vpc.secondary.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = false

  tags = { Name = "secondary-private-b" }
}

resource "aws_internet_gateway" "gw" {
  provider = aws.secondary
  vpc_id = aws_vpc.secondary.id
}

resource "aws_nat_gateway" "nat" {
  provider = aws.secondary
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.private_a.id
}

resource "aws_eip" "nat" {
  provider = aws.secondary
  vpc = true
}
