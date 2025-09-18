module "kms_primary" {
  source     = "terraform-aws-modules/kms/aws"
  version    = "3.1.0"
  create_key = true
  alias_name = "${var.cluster_name}-primary-key"
}

module "kms_secondary" {
  source     = "terraform-aws-modules/kms/aws"
  version    = "3.1.0"
  create_key = true
  alias_name = "${var.cluster_name}-secondary-key"
}