variable "additional_user_data_script" {
  default = ""
}


variable "docker_storage_size" {
 default     = "100"
 description = "EBS Volume size in Gib that the ECS Instance uses for Docker images and metadata "
}

variable "ebs_block_device" {
  default     = "/dev/xvdcz"
  description = "EBS block devices to attach to the instance. (default: /dev/xvdcz)"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
}


variable "environment"{
	description="indicates name of our environment. possible values dev,cit,sit,uat,pprod,prod,n"
	default="dev"
}

variable "cost_centre"{
	description="A part of an organization to which costs may be charged.e.g. finance/it/hr/wholesale/retail/investment etc..."
	default=""
}

variable "region_id"{
	default="euw1"
}

# useful if need to add tag
variable "region"{
	description="region in which resource is created."
	default="eu-west-1"
}

# useful if need to add tag
variable "version_id"{
	description="version of this component.everytime when we are updating this component we need to increment it."
	default=""
}

variable "build_date"{
	description="date on which this component built/modified. format ddmmyyyy e.g. 27122017"
	default=""
}

variable "iam_path" {
  default     = "/"
  description = "IAM path, this is useful when creating resources with the same name across multiple regions. Defaults to /"
}

variable "custom_iam_policy" {
  default     = ""
  description = "Custom IAM policy (JSON). If set will overwrite the default one"
}

# useful if need to add tag
variable "project"{}
variable "vpc_seq_id"{}
variable "seq_id"{}
variable "image_id"{}
variable "key_name"{}
variable "launch_config_sec_group_id"{}
variable "root_volume_size"{}
# we want ec2 instance must be created in private subnet
variable "associate_public_ip_address"{default="false"}
# important for autoscaling
variable "max_size"{}
variable "min_size"{}
variable "desired_capacity"{}
# provide better performance in terms of IO
variable "ebs_optimized"{default="true"}
variable "app_service" {}
variable "maintenance_time" {}
variable "maintenance_day"{}
variable "instance_ebs_optimized"{}
variable "access_key" {}
variable "secret_key" {}
variable "user_data" {default = ""}
