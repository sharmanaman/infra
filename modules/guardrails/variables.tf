variable "policy_name" {
  description = "Name of the guardrail policy"
  type        = string
}

variable "description" {
  description = "Description of the policy"
  type        = string
  default     = ""
}

variable "policy_content" {
  description = "JSON content of the SCP"
  type        = string
}

variable "target_ids" {
  description = "The ID of the target OU or account to attach the SCP to. Leave empty if no attachment is needed."
  type        = list(string)
}