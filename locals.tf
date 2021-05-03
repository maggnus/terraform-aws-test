locals {
  aws_availability_zone_count = length(local.aws_availability_zones)
  aws_availability_zones      = ["ap-southeast-1a", "ap-southeast-1b"]

  vpc_cidr = "10.8.0.0/16"
  # > [for i in range(local.aws_availability_zone_count): cidrsubnet(cidrsubnet(local.vpc_cidr,1,0), 4, i)]
  # [
  #   "10.8.0.0/21",
  #   "10.8.8.0/21",
  # ]
  # > [for i in range(local.aws_availability_zone_count): cidrsubnet(cidrsubnet(local.vpc_cidr,1,1), 4, i)]
  # [
  #   "10.8.128.0/21",
  #   "10.8.136.0/21",
  # ]
  public_subnets  = [for i in range(local.aws_availability_zone_count) : cidrsubnet(cidrsubnet(local.vpc_cidr, 1, 0), 4, i)]
  private_subnets = [for i in range(local.aws_availability_zone_count) : cidrsubnet(cidrsubnet(local.vpc_cidr, 1, 1), 4, i)]

  eks_cluster_name    = "eks"
  eks_cluster_version = "1.17"
  eks_autoscaling_sizes = {
    demo = {
      worker_nodes_desired_capacity = 1
      worker_nodes_min_size         = 1
      worker_nodes_max_size         = 3
    }
  }
  eks_autoscaling = local.eks_autoscaling_sizes[terraform.workspace]

}
