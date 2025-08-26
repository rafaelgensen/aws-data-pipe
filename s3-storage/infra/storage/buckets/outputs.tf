output "raw_data_bucket_name" {
  value = aws_s3_bucket.staging-cinema-data.bucket
}

output "silver_data_bucket_name" {
  value = aws_s3_bucket.silver-cinema-data.bucket
}

output "gold_data_bucket_name" {
  value = aws_s3_bucket.fact-cinema-data.bucket
}