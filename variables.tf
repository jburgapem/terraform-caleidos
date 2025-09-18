variable "primary_region" {
  description = "Región del cluster primario"
  type        = string
}

variable "secondary_region" {
  description = "Región del cluster secundario"
  type        = string
}

variable "cluster_name" {
  description = "Nombre base de los clusters EKS"
  type        = string
}
