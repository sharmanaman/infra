/*
resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

# Create the top-level 'Production' OU
resource "aws_organizations_organizational_unit" "production" {
  name      = "Production"
  parent_id = aws_organizations_organization.org.roots[0].id
}

# Create a nested 'Frontend' OU under 'Production'
resource "aws_organizations_organizational_unit" "frontend" {
  name      = "Frontend"
  parent_id = aws_organizations_organizational_unit.production.id
}


resource "aws_organizations_account" "staging" {
  name      = "staging"
  email     = "staging+aws@yourcompany.com" # A unique, un-used email address
  parent_id = aws_organizations_organizational_unit.frontend.id
}
*/