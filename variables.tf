variable "cluster_name" {
  description = "Base name for the EKS clusters"
  type        = string
  default     = "acme-eks" # cámbialo al nombre base que quieras
}
variable "secondary_vpc_id" {
  description = "VPC ID for the secondary cluster"
  type        = string
}

variable "secondary_private_subnets" {
  description = "Private subnets for the secondary cluster"
  type        = list(string)
}