variable "cluster_name" {
  description = "Base name for the clusters"
  type        = string
  default     = "acme-eks"
}
variable "primary_region" {
  description = "AWS region for the primary cluster"
  type        = string
  default     = "us-east-1"
}

variable "secondary_region" {
  description = "AWS region for the secondary cluster"
  type        = string
  default     = "us-west-2"
}
