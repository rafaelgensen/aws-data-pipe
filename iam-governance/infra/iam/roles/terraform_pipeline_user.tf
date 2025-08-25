resource "aws_iam_user" "terraform_pipeline" {
  name = "terraform-pipeline"
  tags = {
    CreatedBy   = "terraform"
    Environment = "governance"
  }
}

resource "aws_iam_policy" "terraform_pipeline_policy" {
  name   = "terraform-pipeline-policy"
  policy = file("${path.module}/../policies/terraform_deploy_policy.json")
}

resource "aws_iam_user_policy_attachment" "github_actions_terraform_pipeline_attach" {
  user       = aws_iam_user.terraform_pipeline.name
  policy_arn = aws_iam_policy.terraform_pipeline_policy.arn
}

resource "aws_iam_access_key" "github_actions_key_terraform_pipeline" {
  user = aws_iam_user.terraform_pipeline.name
}
