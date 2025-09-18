resource "aws_kms_key" "primary" {
  description             = "KMS key for EKS primary cluster"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "primary" {
  name          = "alias/${var.cluster_name}-primary-key"
  target_key_id = aws_kms_key.primary.key_id
}

module "kms_secondary" {
  source     = "terraform-aws-modules/kms/aws"
  version    = "3.1.0"
  create_key = true
  alias_name = "${var.cluster_name}-secondary-key"
}