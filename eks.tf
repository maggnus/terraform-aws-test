data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}
module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "12.2.0"
  cluster_name                    = local.eks_cluster_name
  cluster_version                 = local.eks_cluster_version
  vpc_id                          = module.vpc.vpc_id
  subnets                         = ""
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  enable_irsa                     = true
  write_kubeconfig                = true

  worker_groups = [
    {
      name                          = "worker-group-private"
      instance_type                 = "t2.medium"
      asg_desired_capacity          = local.eks_autoscaling.worker_nodes_desired_capacity
      asg_min_size                  = local.eks_autoscaling.worker_nodes_min_size
      asg_max_size                  = local.eks_autoscaling.worker_nodes_max_size
      subnets                       = ""
    },
    {
      name                          = "worker-group-public"
      instance_type                 = "t2.medium"
      asg_desired_capacity          = local.aws_availability_zone_count
      asg_min_size                  = local.aws_availability_zone_count
      asg_max_size                  = local.aws_availability_zone_count
      subnets                       = ""
    }
  ]
  map_roles = [
    {
      rolearn  = ""
      username = ""
      groups   = [""]
    }
  ]
}

output "worker_role_arn" {
  value = "${module.eks.worker_iam_role_arn}"
}