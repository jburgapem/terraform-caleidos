<<<<<<< HEAD
# Variables no longer needed since VPCs and subnets are now created directly in network.tf
primary_region = "us-east-1"
secondary_region = "us-east-2"
cluster_name = "acme-eks"
=======
primary_region           = "us-east-1"
secondary_region         = "us-west-2"
cluster_name             = "acme-eks"
primary_vpc_id           = "vpc-0123456789abcdef0"
primary_private_subnets  = ["subnet-aaa111", "subnet-bbb222"]
secondary_vpc_id         = "vpc-0fedcba9876543210"
secondary_private_subnets= ["subnet-xxx111", "subnet-yyy222"]
>>>>>>> main
