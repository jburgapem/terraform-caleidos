provider "aws" {
  alias  = "primary"
  region = "us-east-1" # <-- set your desired region
  # credentials or profile config here
}

provider "aws" {
  alias  = "secondary"
  region = "us-west-2" # <-- set your secondary region
  # credentials or profile config here
}