
terraform {
  required_version = ">= 0.13.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.8.0"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region = var.aws_region
}

module "terraform_state_backend" {
  source                        = "git::https://github.com/cloudposse/terraform-aws-tfstate-backend.git?ref=0.26.0"
  profile                       = var.aws_profile
  namespace                     = var.namespace
  stage                         = "demo"
  name                          = "terraform"
  attributes                    = ["state"]
  enable_server_side_encryption = "true"
  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"

}

output "remote_state_s3_bucket_arn" {
  value = module.terraform_state_backend.s3_bucket_id
}

output "remote_state_dynamo_table_name" {
  value = module.terraform_state_backend.dynamodb_table_name
}

data "aws_availability_zones" "available" {}