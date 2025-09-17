variable "primary_vpc_id" {
  description = "VPC ID for the primary region"
  type        = string
}

variable "primary_private_subnets" {
  description = "Private subnet IDs for the primary region"
  type        = list(string)
}

variable "secondary_vpc_id" {
  description = "VPC ID for the secondary region"
  type        = string
}

variable "secondary_private_subnets" {
  description = "Private subnet IDs for the secondary region"
  type        = list(string)
}

variable "cluster_name" {
  description = "Base name for the clusters"
  type        = string
  default     = "acme-eks"
}
