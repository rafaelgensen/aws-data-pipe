output "s3_bucket_names" {
  description = "Lista com os nomes dos buckets criados"
  value = [
    aws_s3_bucket.raw_data.bucket,
    aws_s3_bucket.silver_data.bucket,
    aws_s3_bucket.gold_data.bucket
  ]
}