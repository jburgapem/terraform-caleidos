#####################################
# KMS KEYS
#####################################
module "kms_primary" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.1.0"

  description        = "KMS key for primary EKS cluster"
  aliases            = ["eks/primary"]
  enable_key_rotation = true
}

module "kms_secondary" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.1.0"

  description        = "KMS key for secondary EKS cluster"
  aliases            = ["eks/secondary"]
  enable_key_rotation = true
}
