#####################################
# Cluster EKS Primario
#####################################
module "eks_primary" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"

  providers = {
    aws = aws.primary
  }

  cluster_name    = "${var.cluster_name}-primary"
  cluster_version = var.eks_version

  vpc_id     = var.primary_vpc_id
  subnet_ids = var.primary_private_subnets

  cluster_security_group_id = aws_security_group.eks_primary_cluster.id
  node_security_group_id    = aws_security_group.eks_primary_nodes.id

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 4
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

  create_kms_key = true
  # If you want encryption, use cluster_encryption_config here

  enable_irsa = true

  tags = var.tags
}

#####################################
# Cluster EKS Secundario
#####################################
module "eks_secondary" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"

  providers = {
    aws = aws.secondary
  }

  cluster = {
    name    = "${var.cluster_name}-secondary"
    version = var.eks_version
  }

  vpc_id     = var.secondary_vpc_id
  subnet_ids = var.secondary_private_subnets

  cluster_security_group_id = aws_security_group.eks_secondary_cluster.id
  node_security_group_ids   = [aws_security_group.eks_secondary_nodes.id]

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 4
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

  create_kms_key = true
  kms_key_arn    = module.kms_secondary.key_arn
  enable_irsa    = true

  tags = var.tags
}
