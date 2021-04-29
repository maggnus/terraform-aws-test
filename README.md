# The Tasks

Now assume you are a DevOps for a brand-new project. 

The Product Owner wants to develop a **three-tier** software solution which includes web UI, API service and DB. The Product Owner also wants to use **AWS** as much as possible, so we decide to use EKS as our server host. We have also determined that Terraform is the language for the infra team.

We already have an initial repo for the infra part (EKS and VPC), but some code is missing. Please extend the code to complete the missing functionality. You should not need to change any of the existing VPC or EKS code.

Based on the code you completed in infra repo, please use Github Actions as CI/CD tool to build and deploy this repo, so it can be applied automatically when you push your code to GitHub.

## Notes
 
These are the three modules we use:

* `cloudposse/terraform-aws-tfstate-backend`
* `terraform-aws-modules/eks/aws`
* `terraform-aws-modules/vpc/aws`

Please use these modules to complete the code.

