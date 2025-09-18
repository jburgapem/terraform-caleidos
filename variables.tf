variable "primary_region" {
  description = "Región del cluster primario"
  type        = string
  default     = "us-east-2"
}

variable "secondary_region" {
  description = "Región del cluster secundario"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Nombre base de los clusters EKS"
  type        = string
  default     = "acme-eks"
}