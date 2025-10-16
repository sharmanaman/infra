variable "ou_name" {
  description = "Name of the Organizational Unit"
  type        = string
}

variable "parent_id" {
  description = "Parent ID for the OU (root or another OU)"
  type        = string
}
