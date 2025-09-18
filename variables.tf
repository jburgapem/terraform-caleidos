# Región y nombres de clusters

variable "primary_region" {
  type = string
}

variable "secondary_region" {
  type = string
}

# VPC y subnets primario

variable "primary_vpc_id" {
  type = string
}

variable "primary_private_subnets" {
  type = list(string)
}
