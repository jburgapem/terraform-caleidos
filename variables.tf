variable "secondary_vpc_id" {
  description = "VPC ID for the secondary cluster"
  type        = string
}

variable "secondary_private_subnets" {
  description = "Private subnets for the secondary cluster"
  type        = list(string)
}