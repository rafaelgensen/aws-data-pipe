variable "bucket_script_path" {
  description = "Caminho no S3 onde está o main.py"
  type        = string
}

variable "bucket_temp_path" {
  description = "Caminho temporário no S3 usado pelo Glue"
  type        = string
}

variable "glue_role_arn" {
  type        = string
  description = "ARN da IAM Role do Glue compartilhada"
}