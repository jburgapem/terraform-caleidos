#############################
# Región y nombres de clusters
#############################
variable "primary_region" {
  description = "Región de AWS para el cluster primario"
  type        = string
  default     = "us-east-1"
}

variable "secondary_region" {
  description = "Región de AWS para el cluster secundario"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Nombre base para los clusters EKS"
  type        = string
  default     = "acme-eks"
}

#############################
# VPC y subnets primario
#############################
variable "primary_vpc_id" {
  description = "ID de la VPC primaria"
  type        = string
}

variable "primary_private_subnets" {
  description = "Subnets privadas de la VPC primaria"
  type        = list(string)
}

#############################
# VPC y subnets secundario
#############################
variable "secondary_vpc_id" {
  description = "ID de la VPC secundaria"
  type        = string
}

variable "secondary_private_subnets" {
  description = "Subnets privadas de la VPC secundaria"
  type        = list(string)
}

