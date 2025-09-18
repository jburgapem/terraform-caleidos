#####################################
# EKS PRIMARY CLUSTER
#####################################
module "eks_primary" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.3.0"
  providers = {
    aws = aws.primary
  }

  cluster_name    = "${var.cluster_name}-primary"
  cluster_version = "1.29"

  vpc_id     = var.primary_vpc_id
  subnet_ids = var.primary_private_subnets

  # Seguridad
  cluster_security_group_id             = var.eks_primary_cluster_sg
  cluster_additional_security_group_ids = [var.eks_primary_nodes_sg]

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
  version = "21.3.0"
  providers = {
    aws = aws.secondary
  }

  cluster_name    = "${var.cluster_name}-secondary"
  cluster_version = "1.29"

  vpc_id     = var.secondary_vpc_id
  subnet_ids = var.secondary_private_subnets

  # Seguridad
  cluster_security_group_id             = var.eks_secondary_cluster_sg
  cluster_additional_security_group_ids = [var.eks_secondary_nodes_sg]

  # Encriptación con su KMS dedicado
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms_secondary.key_arn
  }

  # Node groups
  eks_managed_node_groups = {
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
}



