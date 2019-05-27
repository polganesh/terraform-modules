variable "environment"{
	description="indicates name of our environment. possible values dev,cit,sit,uat,pprod,prod,n"
	default="dev"
}

variable "cost_centre"{
	description="A part of an organization to which costs may be charged.e.g. finance/it/hr/wholesale/retail/investment etc..."
	default=""
}

variable "app_service" {}

variable "seq_id"{}

variable "region_id"{
	default="euw1"
}

# useful if need to add tag
variable "region"{
	description="region in which resource is created."
	default="eu-west-1"
}

variable "eks_version"{
 default="1.12"
 description="define k8s version"
}
variable "vpc_seq_id"{}
variable "image_id"{}
variable "instance_type" {
  default     = "t2.micro"
  description = "AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
}

# variable "instance_ebs_optimized"{}
variable "key_name"{}

# variable "launch_config_sec_group_id"{}
# variable "root_volume_size"{}
# we want ec2 instance must be created in private subnet
variable "associate_public_ip_address"{default="false"}
variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}

