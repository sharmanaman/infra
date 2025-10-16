#module "vpc_1" {
#  source = "./vpc_module"
#  cidr_block = "10.1.0.0/16"
#  private_cidr_block  = "10.1.0.0/16"
#  vpc_name = "My VPC 1"
#  public_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
#  private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
#  azs = ["eu-west-1a", "eu-west-1b"]
#}


#module "vpc_2" {
#  source = "./vpc_module"
#  cidr_block = "10.2.0.0/16"
#  private_cidr_block  = "10.2.0.0/16"
#  vpc_name = "My VPC 2"
#  public_subnet_cidrs = ["10.2.1.0/24", "10.2.2.0/24"]
#  private_subnet_cidrs = ["10.2.3.0/24", "10.2.4.0/24"]
#  azs = ["eu-west-1b", "eu-west-1c"]
#}

# AWS Organization creation (omit if using existing organization)
#resource "aws_organizations_organization" "org" {
#  feature_set = "ALL"
#}

# Create the top-level 'Production_new' OU
module "Production_new" {
  source   = "./modules/ou"
  ou_name  = "Prod"
  parent_id = var.organization_root_id
  #parent_id = aws_organizations_organization.org.roots[0].id
}

# Create a nested 'Frontend' OU under 'Production'
module "frontend" {
  source   = "./modules/ou"
  ou_name  = "Frontend"
  parent_id = module.Production_new.ou_prod_id
}

/*
module "DenyS3Delete" {
  source        = "./modules/guardrails"
  policy_name   = "DenyS3Delete"
  policy_content = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "s3:DeleteBucket",
      "Resource": "*"
    }
  ]
}
EOF
  target_id      = module.ou_prod_id
}

# Deny IAM policy modifications
module "deny_iam_mod" {
  source          = "./modules/guardrails"
  policy_name     = "DenyIAMPolicyModifications"
  policy_content  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyIAMPolicyModifications",
      "Effect": "Deny",
      "Action": [
        "iam:CreatePolicy",
        "iam:CreatePolicyVersion",
        "iam:PutUserPolicy",
        "iam:PutGroupPolicy",
        "iam:PutRolePolicy",
        "iam:AttachUserPolicy",
        "iam:AttachGroupPolicy",
        "iam:AttachRolePolicy",
        "iam:DeletePolicy",
        "iam:DeletePolicyVersion"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  target_id       = module.ou_prod_id
}

*/