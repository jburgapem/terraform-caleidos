# Nombre base para los clusters
cluster_name = "acme-eks"

# VPCs
primary_vpc_id     = "vpc-1234567890abcdef0"
secondary_vpc_id   = "vpc-abcdef0123456789"

# Subnets privadas
primary_private_subnets   = ["subnet-11111111", "subnet-22222222"]
secondary_private_subnets = ["subnet-33333333", "subnet-44444444"]

# Security groups
eks_primary_cluster_sg   = "sg-aaaa1111"
eks_primary_nodes_sg     = "sg-bbbb2222"
eks_secondary_cluster_sg = "sg-cccc3333"
eks_secondary_nodes_sg   = "sg-dddd4444"


