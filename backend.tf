backend "s3" {
  bucket         = "backend-state-jn-dev"
  key            = "dev/eks.tfstate"
  region         = "us-east-2"
  encrypt        = true
}