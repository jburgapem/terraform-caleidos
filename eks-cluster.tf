#####################################
# EKS PRIMARY CLUSTER
#####################################
module "eks_primary" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"
  providers = {
    aws = aws.primary
  }

  cluster_name    = "${var.cluster_name}-primary"
  cluster_version = "1.29"

  vpc_id     = aws_vpc.primary.id
  subnet_ids = [
    aws_subnet.primary_private_a.id,
    aws_subnet.primary_private_b.id
  ]

  # Seguridad
  cluster_security_group_id             = aws_security_group.eks_primary_cluster.id
  cluster_additional_security_group_ids = [aws_security_group.eks_primary_nodes.id]

  # Encriptación con su KMS dedicado
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms_primary.key_arn
  }

  # Node groups
  eks_managed_node_groups = {
    default = {
      min_size       = 1
      max_size       = 4
      desired_size   = 2
      instance_types = ["t3.medium"]
    }
  }

  enable_irsa = true
}

#####################################
# EKS SECONDARY CLUSTER
#####################################
module "eks_secondary" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"
  providers = {
    aws = aws.secondary
  }

  cluster_name    = "${var.cluster_name}-secondary"
  cluster_version = "1.29"

  vpc_id     = aws_vpc.secondary.id
  subnet_ids = [
    aws_subnet.secondary_private_a.id,
    aws_subnet.secondary_private_b.id
  ]

  # Seguridad
  cluster_security_group_id             = aws_security_group.eks_secondary_cluster.id
  cluster_additional_security_group_ids = [aws_security_group.eks_secondary_nodes.id]

  # Encriptación con su KMS dedicado
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms_secondary.key_arn
  }

  # Node groups
  eks_managed_node_groups = {
    default = {
      min_size       = 1
      max_size       = 4
      desired_size   = 2
      instance_types = ["t3.medium"]
    }
  }

  enable_irsa = true
}


