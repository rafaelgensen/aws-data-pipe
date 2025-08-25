module "iam_roles" {
  source = "./iam/roles"
}

##

# resource "aws_iam_policy" "terraform_deploy_policy_felipe" {
#   name   = "terraform-deploy-policy_felip2e"
#   policy = file("${path.module}/iam/policies/terraform_deploy_policy.json")

# }
