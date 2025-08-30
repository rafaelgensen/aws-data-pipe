resource "aws_glue_job" "filter_script" {
  name              = "glue-filter_script-job"
  role_arn          = var.glue_role_arn
  glue_version      = "4.0"
  number_of_workers = 2
  worker_type       = "G.1X"

  command {
    name            = "glueetl"
    script_location = "s3://artifactory-6633-5432-4751/filter_script/filter_script.py"
    python_version  = "3"
  }

  default_arguments = {
    "--extra-py-files" = "s3://artifactory-6633-5432-4751/filter_script/filter_script.zip"
    "--TempDir"        = var.bucket_temp_path
    "--job-language"   = "python"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-metrics"                   = "true"
  }
}
