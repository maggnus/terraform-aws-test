resource "aws_eip" "nat" {
  count = local.aws_availability_zone_count

  vpc = true
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.55.0"

  name = "demo"
  cidr = local.vpc_cidr
  azs  = local.aws_availability_zones

  enable_dns_support       = true
  enable_dns_hostnames     = true
  enable_nat_gateway       = true
  enable_s3_endpoint       = true
  enable_dynamodb_endpoint = true
  enable_vpn_gateway       = true
  map_public_ip_on_launch  = true                 
  one_nat_gateway_per_az   = true
  reuse_nat_ips            = true                 
  external_nat_ip_ids      = "${aws_eip.nat.*.id}"

}
