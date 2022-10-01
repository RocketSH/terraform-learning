terraform {
  backend "s3" {
    bucket = "terraform-learning-eu-central-1-tfstate"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}
