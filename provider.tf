########################################
# AWS Providers para EKS Multi-Region  #
# Compatible con OIDC (GitHub Actions) #
########################################

# Provider AWS primario
provider "aws" {
  alias  = "primary"
  region = var.primary_region

  # Si ejecutas localmente con perfil o variables de entorno
  # aws_access_key_id     = var.aws_access_key_id
  # aws_secret_access_key = var.aws_secret_access_key
  # aws_session_token     = var.aws_session_token
}

# Provider AWS secundario
provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}

# Backend S3 (opcional) para estado remoto
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-<tu-proyecto>"
    key            = "eks/multi-region/terraform.tfstate"
    region         = var.primary_region
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
