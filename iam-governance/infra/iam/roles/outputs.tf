output "github_actions_user_name" {
  value = aws_iam_user.terraform_pipeline.name
}

output "github_actions_access_key_id" {
  value     = aws_iam_access_key.github_actions_key_terraform_pipeline.id
}
