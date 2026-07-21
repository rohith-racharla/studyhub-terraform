terraform {
  backend "s3" {
    bucket         = "studyhub-tf-state-rohithracharla"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "studyhub-tf-locks"
    encrypt        = true
  }
}
