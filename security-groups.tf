# ---------- Security Groups ----------

resource "aws_security_group" "eks_primary" {
  name   = "${var.cluster_name}-primary-sg"
  vpc_id = aws_vpc.primary.id

  description = "EKS primary cluster SG"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "eks_secondary" {
  name   = "${var.cluster_name}-secondary-sg"
  vpc_id = aws_vpc.secondary.id

  description = "EKS secondary cluster SG"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

