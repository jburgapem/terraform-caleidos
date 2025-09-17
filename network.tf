########################
# VPC PRIMARY
########################
resource "aws_vpc" "primary" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "primary-vpc"
  }
}

# Internet Gateway (necesario para NAT + subnets públicas)
resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id
  tags = {
    Name = "primary-igw"
  }
}

# Subnets (dentro del rango de la VPC)
resource "aws_subnet" "primary_public" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "primary-public"
  }
}

resource "aws_subnet" "primary_private" {
  vpc_id            = aws_vpc.primary.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "primary-private"
  }
}

# NAT Gateway + EIP
resource "aws_eip" "primary_nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "primary" {
  allocation_id = aws_eip.primary_nat.id
  subnet_id     = aws_subnet.primary_public.id
  tags = {
    Name = "primary-nat"
  }
  depends_on = [aws_internet_gateway.primary]
}

########################
# VPC SECONDARY
########################
resource "aws_vpc" "secondary" {
  provider              = aws.secondary
  cidr_block            = "10.1.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true
  tags = {
    Name = "secondary-vpc"
  }
}

resource "aws_internet_gateway" "secondary" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary.id
  tags = {
    Name = "secondary-igw"
  }
}

resource "aws_subnet" "secondary_public" {
  provider                = aws.secondary
  vpc_id                  = aws_vpc.secondary.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "secondary-public"
  }
}

resource "aws_subnet" "secondary_private" {
  provider          = aws.secondary
  vpc_id            = aws_vpc.secondary.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "secondary-private"
  }
}

resource "aws_eip" "secondary_nat" {
  provider = aws.secondary
  domain   = "vpc"
}

resource "aws_nat_gateway" "secondary" {
  provider      = aws.secondary
  allocation_id = aws_eip.secondary_nat.id
  subnet_id     = aws_subnet.secondary_public.id
  tags = {
    Name = "secondary-nat"
  }
  depends_on = [aws_internet_gateway.secondary]
}

########################
# VPC PEERING
########################
resource "aws_vpc_peering_connection" "interregion" {
  vpc_id      = aws_vpc.primary.id
  peer_vpc_id = aws_vpc.secondary.id
  peer_region = "us-west-2"
  auto_accept = false

  tags = {
    Name = "primary-to-secondary"
  }
}

# Accepter en la cuenta/region secundaria
resource "aws_vpc_peering_connection_accepter" "secondary" {
  provider                  = aws.secondary
  vpc_peering_connection_id = aws_vpc_peering_connection.interregion.id
  auto_accept               = true

  tags = {
    Name = "secondary-accept"
  }
}
