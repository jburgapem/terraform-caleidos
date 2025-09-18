# module "eks_primary" {
#   source          = "terraform-aws-modules/eks/aws"
#   version         = "20.13.0"
#   providers       = { aws = aws.primary }

#   cluster_name    = "${var.cluster_name}-primary"
#   cluster_version = "1.29"

#   vpc_id     = var.primary_vpc_id
#   subnet_ids = var.primary_private_subnets

#   eks_managed_node_groups = {
#     default = {
#       desired_size   = 2
#       max_size       = 4
#       min_size       = 1
#       instance_types = ["t3.medium"]
#     }
#   }

#   create_kms_key            = false
#   cluster_log_group_enabled = false
#   enable_irsa               = true
#   manage_aws_auth           = true
# }

module "eks_secondary" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"
  providers = { aws = aws.secondary }

  cluster_name    = "acme-eks-secondary"
  cluster_version = "1.29"

  vpc_id     = aws_vpc.secondary.id
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  # Roles y nodos gestionados
  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 4
      min_size       = 1
      instance_types = ["t3.medium"]
      disk_size      = 20
      remote_access  = {
        ec2_ssh_key = "mi-keypair" # Cambia por tu keypair
      }
    }
  }

  create_kms_key = true
  enable_irsa    = true
}