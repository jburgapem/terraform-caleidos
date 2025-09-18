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
}

variable "secondary_vpc_id" {
  type = string
}

variable "secondary_private_subnets" {
  type = list(string)
}
