output "github_actions_user_name" {
  value = module.iam_roles.github_actions_user_name
}

output "github_actions_access_key_id" {
  value     = module.iam_roles.github_actions_access_key_id
}
