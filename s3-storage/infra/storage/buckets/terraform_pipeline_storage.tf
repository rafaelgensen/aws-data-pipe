provider "aws" {
  region = "us-east-1"
}

# Bucket 1 - One Zone IA
resource "aws_s3_bucket" "raw_data" {
  bucket = "raw_data_663354324751"
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_raw_data" {
  bucket = aws_s3_bucket.raw_data.id

  rule {
    id     = "move-to-one-zone-ia"
    status = "Enabled"

    filter {}

    transition {
      days          = 0
      storage_class = "ONEZONE_IA"
    }
  }
}

# Bucket 2 - One Zone IA
resource "aws_s3_bucket" "silver_data" {
  bucket = "silver_data_663354324751"
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_silver_data" {
  bucket = aws_s3_bucket.silver_data.id

  rule {
    id     = "move-to-one-zone-ia"
    status = "Enabled"

    filter {}

    transition {
      days          = 0
      storage_class = "ONEZONE_IA"
    }
  }
}

# Bucket 3 - Standard (default)
resource "aws_s3_bucket" "gold_data" {
  bucket = "gold_data_663354324751"
}

# Bucket de logs
resource "aws_s3_bucket" "log_bucket" {
  bucket = "logs_bucket_prod_663354324751"
}

# Habilitar logging
resource "aws_s3_bucket_logging" "data_logging" {
  bucket = aws_s3_bucket.gold_data.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "logs/"
}

resource "aws_s3_bucket_policy" "log_bucket_policy" {
  bucket = aws_s3_bucket.log_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "S3ServerAccessLogsPolicy",
        Effect    = "Allow",
        Principal = {
          Service = "logging.s3.amazonaws.com"
        },
        Action    = "s3:PutObject",
        Resource  = "${aws_s3_bucket.log_bucket.arn}/logs/*",
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = "663354324751"
          }
        }
      }
    ]
  })
}