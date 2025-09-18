# output "eks_primary_cluster_id" {
#   value = module.eks_primary.cluster_id
# }

output "eks_secondary_cluster_endpoint" {
  value = module.eks_secondary.cluster_endpoint
}

output "eks_secondary_cluster_name" {
  value = module.eks_secondary.cluster_id
}

output "eks_secondary_cluster_security_group_id" {
  value = module.eks_secondary.cluster_security_group_id
}