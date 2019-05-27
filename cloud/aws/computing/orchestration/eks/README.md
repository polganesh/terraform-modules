# README #
Initial Ideas for creating this module from 
https://learn.hashicorp.com/terraform/aws/eks-intro

## Prerequisite
To Create EKS cluster with this module  
- Following softwares must be installed
  - AWS CLI - This terraform module internally _add tags to public and private subnet_ hence it is needed and must be _configured_.
  - Kubectl - useful for interacting with k8s cluster.
  - aws-iam-authenticator - glue between kubectl and aws IAM authentication
- This module depends on VPC module of this Repository to create EKS cluster. non default VPC _must_ be present in AWS account region where we are planning to create EKS and must be created with VPC module present in this repository .


## Capabilities of this module ##
- Create IAM role
  - for EKS cluster
  - for worker nodes
- Attach worker node role to IAM instance profile
- security groups enable communication between
  -  worker and  master nodes
  -  various worker nodes
- EKS cluster
  - created in VPC of format _vpc-region_id_*cost_centre-vpc_seq_id_
- EC2 worker nodes
  - inside subnet name consistof _-privApp-_. i.e. subnet specific to hosting applications in private subnet
- Tag 
   - private subnet as
     - kubernetes.io/cluster/_cluster-name_ with value shared
   - public subnet as
     - kubernetes.io/cluster/_cluster-name_ with value shared
     - kubernetes.io/role/elb with value 1
