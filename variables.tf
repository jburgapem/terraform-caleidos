variable "cluster_name" {
  description = "Nombre base de los clusters"
  type        = string
  default     = "acme-eks"
}

variable "primary_region" {
  description = "Región del cluster primario"
  type        = string
  default     = "us-east-1"
}

variable "secondary_region" {
  description = "Región del cluster secundario"
  type        = string
  default     = "us-west-2"
}

variable "primary_vpc_id" {
  description = "ID de la VPC primaria"
  type        = string
}

variable "primary_private_subnets" {
  description = "Subnets privadas primarias"
  type        = list(string)
}

variable "secondary_vpc_id" {
  description = "ID de la VPC secundaria"
  type        = string
}

variable "secondary_private_subnets" {
  description = "Subnets privadas secundarias"
  type        = list(string)
}

variable "create_kms_key" {
  description = "Crear key KMS para cifrado de cluster"
  type        = bool
  default     = false
}
