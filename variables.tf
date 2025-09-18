# Región y nombres de clusters
# variable "primary_region" {
#   description = "Región AWS del cluster primario"
#   type        = string
# }

variable "secondary_region" {
  description = "Región AWS del cluster secundario"
  type        = string
}

variable "cluster_name" {
  description = "Nombre base del cluster"
  type        = string
}

# VPC y subnets primario
# variable "primary_vpc_id" {
#   description = "ID de la VPC primaria"
#   type        = string
# }

# variable "primary_private_subnets" {
#   description = "Lista de subnets privadas del cluster primario"
#   type        = list(string)
# }

# VPC y subnets secundario
variable "secondary_vpc_id" {
  description = "ID de la VPC secundaria"
  type        = string
}

variable "secondary_private_subnets" {
  description = "Lista de subnets privadas del cluster secundario"
  type        = list(string)
}

# Opcional: tamaño de los node groups
variable "node_group_desired_size" {
  description = "Tamaño deseado de los nodos"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "Tamaño mínimo de los nodos"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Tamaño máximo de los nodos"
  type        = number
  default     = 4
}

variable "node_group_instance_types" {
  description = "Tipos de instancias para los node groups"
  type        = list(string)
  default     = ["t3.medium"]
}
