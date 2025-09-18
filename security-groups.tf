# Security Group para el cluster primario
resource "aws_security_group" "eks_primary_cluster" {
  provider = aws.primary
  name     = "${var.cluster_name}-primary-cluster-sg"
  vpc_id   = aws_vpc.primary.id

  description = "Security group for EKS primary cluster control plane"
  tags = {
    Name = "${var.cluster_name}-primary-cluster"
  }
}

# Security Group para los nodos primarios
resource "aws_security_group" "eks_primary_nodes" {
  provider = aws.primary
  name     = "${var.cluster_name}-primary-nodes-sg"
  vpc_id   = aws_vpc.primary.id

  description = "Security group for EKS primary worker nodes"
  tags = {
    Name = "${var.cluster_name}-primary-nodes"
  }

  # Permitir comunicación con el control plane
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.eks_primary_cluster.id]
  }

  # Permitir egress a todo
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group para el cluster secundario
resource "aws_security_group" "eks_secondary_cluster" {
  provider = aws.secondary
  name     = "${var.cluster_name}-secondary-cluster-sg"
  vpc_id   = aws_vpc.secondary.id

  description = "Security group for EKS secondary cluster control plane"
  tags = {
    Name = "${var.cluster_name}-secondary-cluster"
  }
}

# Security Group para los nodos secundarios
resource "aws_security_group" "eks_secondary_nodes" {
  provider = aws.secondary
  name     = "${var.cluster_name}-secondary-nodes-sg"
  vpc_id   = aws_vpc.secondary.id

  description = "Security group for EKS secondary worker nodes"
  tags = {
    Name = "${var.cluster_name}-secondary-nodes"
  }

  # Permitir comunicación con el control plane
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.eks_secondary_cluster.id]
  }

  # Permitir egress a todo
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


