resource "aws_organizations_organizational_unit" "org" {
  name      = var.ou_name
  parent_id = var.parent_id
}