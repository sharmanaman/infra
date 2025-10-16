resource "aws_service_control_policy" "this" {
  name        = var.policy_name
  description = var.description
  content     = var.policy_content
}

# Optional: Attach the SCP to a target (OU or account)
resource "aws_service_control_policy_attachment" "this" {
  count     = var.target_id != "" ? 1 : 0
  policy_id = aws_service_control_policy.this.id
  target_id = var.target_id
}


output "policy_id" {
  value = aws_service_control_policy.this.id
}
