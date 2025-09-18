cluster_name               = "acme-eks"
primary_region             = "us-east-2"
secondary_region           = "us-west-2"

primary_vpc_id             = "vpc-0abc123456789def0"
primary_private_subnets    = ["subnet-0123456789abcdef0", "subnet-0fedcba9876543210"]

secondary_vpc_id           = "vpc-0fedcba9876543210"
secondary_private_subnets  = ["subnet-0a1b2c3d4e5f6g7h8", "subnet-0h8g7f6e5d4c3b2a1"]
