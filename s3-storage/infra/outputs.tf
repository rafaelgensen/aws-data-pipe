module "storage_buckets" {
  source = "./storage/buckets"
}

output "s3_bucket_names" {
  description = "Lista com os nomes dos buckets criados"
  value = [
    module.storage_buckets.raw_data_bucket_name,
    module.storage_buckets.silver_data_bucket_name,
    module.storage_buckets.gold_data_bucket_name
  ]
}