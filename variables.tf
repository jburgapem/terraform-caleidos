variable "cluster_name" {
  description = "Nombre base del cluster"
  type        = string
}

# variable "primary_region" {
#   description = "Región AWS del cluster primario"
#   type        = string
# }

variable "secondary_region" {
  description = "Región AWS del cluster secundario"
  type        = string
}

# variable "primary_vpc_id" {
#   description = "ID de la VPC primaria"
#   type        = string
# }

variable "primary_private_subnets" {
  description = "Subnets privadas del cluster primario"
  type        = list(string)
}

variable "secondary_vpc_id" {
  description = "ID de la VPC secundaria"
  type        = string
}

variable "secondary_private_subnets" {
  description = "Subnets privadas del cluster secundario"
  type        = list(string)
