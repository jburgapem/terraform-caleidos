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
  availability_zone = "us-east-1a"
  tags = {
    Name = "primary-private-a"
  }
}

resource "aws_subnet" "primary_private_b" {
  provider          = aws.primary
  vpc_id            = aws_vpc.primary.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "primary-private-b"
  }
}

resource "aws_vpc" "secondary" {
  provider   = aws.secondary
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "secondary-vpc"
  }
}

resource "aws_subnet" "secondary_private_a" {
  provider          = aws.secondary
  vpc_id            = aws_vpc.secondary.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "secondary-private-a"
  }
}

resource "aws_subnet" "secondary_private_b" {
  provider          = aws.secondary
  vpc_id            = aws_vpc.secondary.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "secondary-private-b"
  }
}
