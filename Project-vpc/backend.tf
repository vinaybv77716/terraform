terraform {
  backend "s3" {
    bucket         = "vinayfromdevops"
    key            = "vinay/from/devops/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "vinayfromdevops"
    encrypt        = true
  }
}
