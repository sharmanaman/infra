resource "aws_organizations_policy" "this" {
  name        = var.policy_name
  description = var.description
  content     = var.policy_content
}

# Optional: Attach the SCP to a target (OU or account)
resource "aws_organizations_policy_attachment" "this" {
  policy_id = aws_organizations_policy.this.id
  target_id = var.target_id
}


output "policy_id" {
  value = aws_organizations_policy_attachment.this.id
}
