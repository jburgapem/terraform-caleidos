<<<<<<< HEAD
variable "cluster_name" {
  description = "Base name for the clusters"
  type        = string
  default     = "acme-eks"
=======
# variables.tf
variable "primary_region" {
  type = string
}

variable "secondary_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "primary_vpc_id" {
  type = string
}

variable "primary_private_subnets" {
  type = list(string)
>>>>>>> main
}

variable "secondary_vpc_id" {
  type = string
}

variable "secondary_private_subnets" {
  type = list(string)
}
