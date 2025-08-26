output "raw_data_bucket_name" {
  value = aws_s3_bucket.raw_data.bucket
}

output "silver_data_bucket_name" {
  value = aws_s3_bucket.silver_data.bucket
}

output "gold_data_bucket_name" {
  value = aws_s3_bucket.gold_data.bucket
}