resource "aws_organizations_policy" "this" {
  name        = var.policy_name
  description = var.description
  content     = var.policy_content
}

# Optional: Attach the SCP to a target (OU or account)
resource "aws_organizations_policy_attachment" "this" {
  for_each  = { for idx, val in var.target_ids : idx => val }
  policy_id = aws_organizations_policy.this.id
  target_id = each.value
}


output "policy_id" {
  value = aws_organizations_policy_attachment.this[0].id
}
