provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "studyhub"
      ManagedBy   = "terraform"
      Environment = "bootstrap"
    }
  }
}
