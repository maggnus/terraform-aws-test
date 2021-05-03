terraform {
  required_providers {
    aws = {
      # Error:
      # Could not retrieve the list of available versions for provider hashicorp/aws:
      # no available releases match the given constraints ~> 3.8.0, >= 2.0.*, >=
      # 2.70.*, >= 3.22.0, >= 3.22.0, >= 3.22.0
      version = ">= 3.10.0"
    }
  }
}

terraform {
  backend "s3" {
    // Singapore region
    region  = "ap-southeast-1"
    bucket  = "terraform-20210429"
    key     = "terraform.tfstate"
    encrypt = true
  }
}

module "terraform_state_backend" {
  profile   = "prod"
  namespace = "tomo"
}

module "vpc" {
  # Error: multiple VPC Endpoint Services matched
  # https://github.com/terraform-aws-modules/terraform-aws-vpc/issues/582
  version         = "2.75.0"
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
}

module "eks" {
  version = "15.1.0"
  subnets = concat(module.vpc.private_subnets, module.vpc.public_subnets)
  worker_groups = [
    {
      subnets = module.vpc.private_subnets
      # Error creating launch configuration: ValidationError: gp3 is invalid. Valid volume types are standard, io1, gp2, st1 and sc1.
      root_volume_type = "gp2"
    },
    {
      subnets = module.vpc.public_subnets
      # Error creating launch configuration: ValidationError: gp3 is invalid. Valid volume types are standard, io1, gp2, st1 and sc1.
      root_volume_type = "gp2"
    }
  ]
}

