# ---------- VPCs ----------
resource "aws_vpc" "primary" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.cluster_name}-primary-vpc"
  }
}

resource "aws_vpc" "secondary" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.cluster_name}-secondary-vpc"
  }
}

# ---------- Subnets ----------
resource "aws_subnet" "primary_private_a" {
  vpc_id            = aws_vpc.primary.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.primary_region}a"
}

resource "aws_subnet" "primary_private_b" {
  vpc_id            = aws_vpc.primary.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.primary_region}b"
}

resource "aws_subnet" "secondary_private_a" {
  vpc_id            = aws_vpc.secondary.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "${var.secondary_region}a"
}

resource "aws_subnet" "secondary_private_b" {
  vpc_id            = aws_vpc.secondary.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "${var.secondary_region}b"
}

