#####################################
# General
#####################################
variable "cluster_name" {
  description = "Nombre base para los clusters EKS"
  type        = string
}

#####################################
# VPCs y Subnets
#####################################
variable "primary_vpc_id" {
  description = "VPC ID para el cluster EKS primario"
  type        = string
}

variable "primary_private_subnets" {
  description = "Subnets privadas en el VPC primario"
  type        = list(string)
}

variable "secondary_vpc_id" {
  description = "VPC ID para el cluster EKS secundario"
  type        = string
}

variable "secondary_private_subnets" {
  description = "Subnets privadas en el VPC secundario"
  type        = list(string)
}
#####################################
# Security Groups
#####################################
variable "eks_primary_cluster_sg" {
  description = "Security Group para el cluster primario"
  type        = string
}

variable "eks_primary_nodes_sg" {
  description = "Security Group para los nodos primarios"
  type        = string
}

variable "eks_secondary_cluster_sg" {
  description = "Security Group para el cluster secundario"
  type        = string
}

variable "eks_secondary_nodes_sg" {
  description = "Security Group para los nodos secundarios"
  type        = string
}