module "eks_primary" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.13.0"
  providers       = { aws = aws.primary }

  cluster_name    = "${var.cluster_name}-primary"
  cluster_version = "1.29"

  vpc_id     = aws_vpc.primary.id
  subnet_ids = [aws_subnet.primary_private_a.id, aws_subnet.primary_private_b.id]

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 4
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

<<<<<<< HEAD
  create_kms_key = true
  enable_irsa    = true
=======
  # Evitar crear KMS y CloudWatch logs
  create_kms_key            = false
  cluster_log_group_enabled = false
  enable_irsa               = true
>>>>>>> main
}

module "eks_secondary" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.13.0"
  providers       = { aws = aws.secondary }

  cluster_name    = "${var.cluster_name}-secondary"
  cluster_version = "1.29"

  vpc_id     = aws_vpc.secondary.id
  subnet_ids = [aws_subnet.secondary_private_a.id, aws_subnet.secondary_private_b.id]

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 4
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

<<<<<<< HEAD
  create_kms_key = true
  enable_irsa    = true
=======
  create_kms_key            = false
  cluster_log_group_enabled = false
  enable_irsa               = true
>>>>>>> main
}
