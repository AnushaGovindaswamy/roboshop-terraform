terraform {
  backend "s3" {
    bucket = "terraform-1996"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}