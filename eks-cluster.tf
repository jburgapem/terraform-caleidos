module "eks_primary" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.13.0"
  providers       = { aws = aws.primary }

  cluster_name    = "${var.cluster_name}-primary"
  cluster_version = "1.29"

  vpc_id     = var.primary_vpc_id
  subnet_ids = var.primary_private_subnets

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 4
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

  # Evitar crear KMS y CloudWatch logs
  create_kms_key            = false
  cluster_log_group_enabled = false
  enable_irsa               = true
}

module "eks_secondary" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.13.0"
  providers       = { aws = aws.secondary }

  cluster_name    = "${var.cluster_name}-secondary"
  cluster_version = "1.29"

  vpc_id     = var.secondary_vpc_id
  subnet_ids = var.secondary_private_subnets

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 4
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

  create_kms_key            = false
  cluster_log_group_enabled = false
  enable_irsa               = true
}
