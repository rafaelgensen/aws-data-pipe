terraform {
  backend "s3" {
    bucket         = "artifactory-6633-5432-4751"
    key            = "backend-tf/infra-governance/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
