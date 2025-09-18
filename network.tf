resource "aws_vpc" "primary" {
  provider   = aws.primary
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "primary-vpc"
  }
}

resource "aws_subnet" "primary_private_a" {
  provider          = aws.primary
  vpc_id            = aws_vpc.primary.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.primary_region}a"
  tags = {
    Name = "primary-private-a"
  }
}

resource "aws_subnet" "primary_private_b" {
  provider          = aws.primary
  vpc_id            = aws_vpc.primary.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.primary_region}b"
  tags = {
    Name = "primary-private-b"
  }
}

resource "aws_vpc" "secondary" {
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
# Security Group para EKS Primario
resource "aws_security_group" "eks_primary" {
  name        = "${var.cluster_name}-primary-sg"
  description = "Security group for EKS primary cluster"
  vpc_id      = var.primary_vpc_id

  # Reglas de entrada
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Reglas de salida
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-primary-sg"
  }
}

# Security Group para EKS Secundario
resource "aws_security_group" "eks_secondary" {
  name        = "${var.cluster_name}-secondary-sg"
  description = "Security group for EKS secondary cluster"
  vpc_id      = var.secondary_vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-secondary-sg"
  }
}
