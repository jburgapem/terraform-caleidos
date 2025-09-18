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

variable "primary_vpc_id" {
  description = "VPC ID for the primary EKS cluster"
  type        = string
}

variable "primary_private_subnets" {
  description = "Private subnet IDs for the primary EKS cluster"
  type        = list(string)
}