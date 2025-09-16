variable "primary_region" {
  default = "us-east-1"
}
variable "secondary_region" {
  default = "us-west-2"
}
variable "cluster_name" {
  default = "acme-eks"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
