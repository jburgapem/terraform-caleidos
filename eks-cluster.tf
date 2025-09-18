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
  #node_security_group_ids   = [aws_security_group.eks_primary_nodes.id]

  # Managed Node Groups con auto-escalado
  managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 4
      min_capacity     = 1
      instance_types   = ["t3.medium"]

      scaling_config = {
        min_size     = 1
        max_size     = 4
        desired_size = 2
      }

      tags = {
        Environment = "prod"
        Role        = "worker"
      }
    }
  }

  # Fargate Profile para pods ligeros o workloads serverless
  fargate_profiles = {
    default = {
      name                 = "fp-default"
      pod_execution_role_arn = module.iam_role_fargate_primary.arn
      selectors = [
        {
          namespace = "default"
        },
        {
          namespace = "kube-system"
        }
      ]
      subnet_ids = [
        aws_subnet.primary_private_a.id,
        aws_subnet.primary_private_b.id
      ]
    }
  }

  enable_irsa = true

  # KMS Encryption
  encryption_config = [
    {
      resources    = ["secrets"]
      provider_arn = module.kms_primary.key_arn
    }
  ]

  # Tags generales del cluster
  tags = {
    Environment = "prod"
    Project     = "acme"
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
      pod_execution_role_arn = module.iam_role_fargate_secondary.arn
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

