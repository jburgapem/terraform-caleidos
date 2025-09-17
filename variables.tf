variable "cluster_name" {
  type    = string
  default = "acme-eks"
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
