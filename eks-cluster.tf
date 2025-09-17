module "eks_primary" {
  source  = "terraform-aws-modules/eks/aws"
  providers = { aws = aws.primary }
  version  = "20.13.0"

  cluster_name    = "${var.cluster_name}-primary"
  cluster_version = "1.29"
  vpc_id          = aws_vpc.primary.id
  subnet_ids      = [aws_subnet.primary_private.id]

  # 🔧 Desactivar creación automática de recursos conflictivos
  create_cloudwatch_log_group = false
  create_kms_key              = false
  attach_cluster_encryption_policy = false

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 4
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }
}

module "eks_secondary" {
  source  = "terraform-aws-modules/eks/aws"
  providers = { aws = aws.secondary }
  version  = "20.13.0"

  cluster_name    = "${var.cluster_name}-secondary"
  cluster_version = "1.29"
  vpc_id          = aws_vpc.secondary.id
  subnet_ids      = [aws_subnet.secondary_private.id]

  # 🔧 Desactivar creación automática de recursos conflictivos
  create_cloudwatch_log_group = false
  create_kms_key              = false
  attach_cluster_encryption_policy = false

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 4
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }
}
