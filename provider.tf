provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "StudyHub"
      ManagedBy   = "Terraform"
      Environment = "production"
    }
  }
}
