# This data source is included for ease of sample architecture deployment
# and can be swapped out as necessary.
data "aws_region" "current" {}


# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  worker-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.main.endpoint}' --b64-cluster-ca '${aws_eks_cluster.main.certificate_authority.0.data}' 'eks-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id}'
USERDATA
}


# ---------------------------------
# resource for launch configuration
# ---------------------------------

/**
resource "aws_launch_configuration" "demo" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.demo-node.name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "m4.large"
  name_prefix                 = "terraform-eks-demo"
  security_groups             = ["${aws_security_group.demo-node.id}"]
  user_data_base64            = "${base64encode(local.demo-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}
**/



resource "aws_launch_configuration" "eks" {
  name = "lcg-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Eks-${var.seq_id}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  #ebs_optimized               = "${var.instance_ebs_optimized}"
  iam_instance_profile        = "${aws_iam_instance_profile.node.name}"
  key_name                    = "${var.key_name}"
  
  security_groups             = ["${aws_security_group.tf-eks-node.id}"]
  associate_public_ip_address = "false"
  user_data_base64            = "${base64encode(local.worker-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "main" {
  name = "asg-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Eks-${var.seq_id}"
  desired_capacity     = ${var.desired_capacity}"
  
  launch_configuration = "${aws_launch_configuration.eks.id}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  vpc_zone_identifier  = ["${data.aws_subnet_ids.private_app_subnets.ids}"]

  tag {
		key                 = "Name"
		value               = "ec2-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Eks-${var.seq_id}"
		propagate_at_launch = true
	}

  tag {
    key                 = "kubernetes.io/cluster/eks-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id}"
    value               = "owned"
    propagate_at_launch = true
  }
}