# Nombres y regiones
variable "cluster_name" {
  description = "Nombre base del cluster EKS"
  type        = string
}

variable "primary_region" {
  description = "Región del cluster primario"
  type        = string
}

variable "secondary_region" {
  description = "Región del cluster secundario"
  type        = string
}

# VPC y subnets
variable "primary_vpc_id" {
  description = "ID del VPC primario"
  type        = string
}

variable "primary_private_subnets" {
  description = "Subnets privadas del VPC primario"
  type        = list(string)
}

variable "secondary_vpc_id" {
  description = "ID del VPC secundario"
  type        = string
}

variable "secondary_private_subnets" {
  description = "Subnets privadas del VPC secundario"
  type        = list(string)
}

