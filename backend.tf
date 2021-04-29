terraform {
  required_version = "0.13.3"

  backend "s3" {
    // Singapore region
    region         = "ap-southeast-1"
    bucket         = ""
    dynamodb_table = ""
    key            = "terraform.tfstate"
    encrypt        = true
  }
}
