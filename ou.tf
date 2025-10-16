/*
resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

# Create the top-level 'Production_new' OU
resource "aws_organizations_organizational_unit" "prod_new" {
  name      = "Production_new"
  parent_id = aws_organizations_organization.org.roots[0].id
}

# Create a nested 'Frontend' OU under 'Production'
resource "aws_organizations_organizational_unit" "front_new" {
  name      = "Frontend_new"
  parent_id = aws_organizations_organizational_unit.production.id
}


resource "aws_organizations_account" "staging_new" {
  name      = "staging_new"
  email     = var.account_email # A unique, un-used email address
  parent_id = aws_organizations_organizational_unit.frontend.id
}
*/