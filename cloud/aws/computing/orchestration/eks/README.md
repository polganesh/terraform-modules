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
     
## Example
```
module "ekscluster"{
   	source="git::https://github.com/polganesh/terraform-modules.git//cloud/aws/computing/orchestration/eks"
	region="eu-central-1"
	region_id="euc1"
	cost_centre="infra"
	vpc_seq_id="001"
	seq_id="001"
	environment="dev"
	app_service="poc"
	image_id="ami-0c348c78b4a0db989"
	instance_type="m4.large"
	key_name="nonprod"
	desired_capacity="2"
	min_size="2"
	max_size="4"
}
```
## Configure - Post EKS cluster creation
following are one times activities

### Configure kubectl
following example assume we are using windows machine,but similar steps can be followed for other OS.
it will copy config available from terraform output for module ekscluster in <user-home

![alt text](https://github.com/polganesh/wiki-images/blob/master/terraform-examples/k8s-aws-kubectl-config.JPG)

### Configure config_map_aws_auth
- get output of config_map_aws_auth
![alt text](https://github.com/polganesh/wiki-images/blob/master/terraform-examples/config_map_aws_auth.JPG)
- store it as k8s config map yaml
- execute it
![alt text](https://github.com/polganesh/wiki-images/blob/master/terraform-examples/output-config-map-with-nodes.JPG)

### K8s Dashboard Configuration (Required)
- This step is required in order to view status of various K8s resources in cluster.
- [[Refer](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html)]

### Configure Helm Chart (Optional)
- This step is not required if you are running K8s cluster on experimental basis but required if we are running production ready cluster and when need to host multiple complex micro services to be hosted on k8s cluster with helm charts.
- steps
```
kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
```





     
     
