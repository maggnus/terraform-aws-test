locals {
  aws_availability_zone_count = ""
  aws_availability_zones = ""

  vpc_cidr         = ""

  eks_cluster_name = "eks"
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
