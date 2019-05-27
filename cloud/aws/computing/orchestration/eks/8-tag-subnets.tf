# it is important that all public subnets must be tagged with keys 
# kubernetes.io/cluster/<cluster-name> shared 
# kubernetes.io/role/elb 1 for external load balancers
resource "null_resource" "tag-public-subnet" {
	provisioner "local-exec" {
		command = "aws create-tags --resources ${element(data.aws_subnet_ids.public_subnets.ids, count.index)} --tags Key=kubernetes.io/role/elb,Value=5"
	}
	
	provisioner "local-exec" {
		command = "aws create-tags --resources ${element(data.aws_subnet_ids.public_subnets.ids, count.index)} --tags Key=kubernetes.io/cluster/eks-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id},Value=shared-test"
	}
	
	depends_on = ["aws_eks_cluster.main"]

}