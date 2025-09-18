terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "primary"
  region = var.primary_region
  profile = "jen"
}

provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
  profile = "jen"
}

backend "s3" {
    bucket = "backend-state-jn-dev"
    key    = "dev/eks.tfstate"
    region = "us-east-2"
    # opcional:
    # dynamodb_table = "terraform-locks"
    # encrypt        = true
  }