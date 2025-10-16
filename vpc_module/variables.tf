variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_cidr_block" {
  description = "CIDR block for the private route table"
  type        = string
  default     = "10.0.0.0/16"  
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
  default     = []
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = []
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "Infra-Vpc"
}
