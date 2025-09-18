# ------------------------------
# EKS Primary Cluster
# ------------------------------
module "eks_primary" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"
  providers = { aws = aws.primary }

  cluster_name    = "${var.cluster_name}-primary"
  cluster_version = "1.29"

  vpc_id     = aws_vpc.primary.id
  subnet_ids = [
    aws_subnet.primary_private_a.id,
    aws_subnet.primary_private_b.id
  ]

  cluster_security_group_id = aws_security_group.eks_primary_cluster.id

  fargate_profiles = {
    default = {
      name                   = "fp-default"
      pod_execution_role_arn = aws_iam_role.fargate_primary.arn
      selectors = [
        { namespace = "default" },
        { namespace = "kube-system" }
      ]
      subnet_ids = [
        aws_subnet.primary_private_a.id,
        aws_subnet.primary_private_b.id
      ]
    }
  }

  enable_irsa = true

  tags = {
    Environment = "prod"
    Project     = "acme"
  }
}

resource "aws_eks_node_group" "primary_default" {
  cluster_name    = module.eks_primary.cluster_name
  node_group_name = "primary-default"
  node_role_arn   = module.eks_primary.node_group_iam_role_arn
  subnet_ids      = [
    aws_subnet.primary_private_a.id,
    aws_subnet.primary_private_b.id
  ]
  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }
  instance_types = ["t3.medium"]
  tags = {
    Environment = "prod"
    Project     = "acme"
    Role        = "primary-worker"
  }
}

# ------------------------------
# EKS Secondary Cluster
# ------------------------------
module "eks_secondary" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"
  providers = { aws = aws.secondary }

  cluster_name    = "${var.cluster_name}-secondary"
  cluster_version = "1.29"

  vpc_id     = aws_vpc.secondary.id
  subnet_ids = [
    aws_subnet.secondary_private_a.id,
    aws_subnet.secondary_private_b.id
  ]

  cluster_security_group_id = aws_security_group.eks_secondary_cluster.id

  fargate_profiles = {
    default = {
      name                   = "fp-default"
      pod_execution_role_arn = aws_iam_role.fargate_secondary.arn
      selectors = [
        { namespace = "default" },
        { namespace = "kube-system" }
      ]
      subnet_ids = [
        aws_subnet.secondary_private_a.id,
        aws_subnet.secondary_private_b.id
      ]
    }
  }

  enable_irsa = true

  tags = {
    Environment = "prod"
    Project     = "acme"
  }
}

resource "aws_eks_node_group" "secondary_default" {
  cluster_name    = module.eks_secondary.cluster_name
  node_group_name = "secondary-default"
  node_role_arn   = module.eks_secondary.node_group_iam_role_arn
  subnet_ids      = [
    aws_subnet.secondary_private_a.id,
    aws_subnet.secondary_private_b.id
  ]
  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }
  instance_types = ["t3.medium"]
  tags = {
    Environment = "prod"
    Project     = "acme"
    Role        = "secondary-worker"
  }
}

