# Regiones
primary_region   = "us-east-1"
secondary_region = "us-west-2"

# Nombre base de los clusters
cluster_name = "acme-eks"

# VPC primaria y subnets privadas
primary_vpc_id           = "vpc-0abc123456789def0"
primary_private_subnets  = ["subnet-0aaa1111", "subnet-0bbb2222"]

# VPC secundaria y subnets privadas
secondary_vpc_id         = "vpc-0fedcba9876543210"
secondary_private_subnets = ["subnet-0ccc3333", "subnet-0ddd4444"]
