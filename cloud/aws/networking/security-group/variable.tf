variable "region_id" {
  description = "Defines the ID of the region for the Security Group. e.g euw1"
  default = "euw1"
}

variable "region"{
	description="region in which resource is created."
	default="eu-west-1"
}

variable "cost_centre" {}

variable "environment" {
  description = "The name of your environment, e.g. p for production n for non-production, or dev/sit/uat etc"
  default = ""
}

variable "vpc_seq_id" {
  description = "Defines the VPC Sequence ID that the Security Group will be associated with. e.g 001"
  default = ""
}

variable "app_service" {
  description = ""
  default = ""
}

variable "sg_for" {
  description = "indicates it is for ECS, EKS or any other cluster"
  default = ""
}

variable "seq_id" {
  description = "Defines the unique sequence ID for the Security Group. e.g 001"
  default = ""
}

variable "sg_description" {
  description = "Defines the description for the security group. Should contain the name of the associated resource."
  default = "Security Group managed by Terraform"
}

variable "version_id" {
  description = "Defines the description for the security group. Should contain the name of the associated resource."
  default = "Security Group managed by Terraform"
}

variable "build_date" {
  description = "The date of build (yyyymmdd), e.g. 20170701"
  default = ""
}

variable "app_role" {
  description = "The name of the application role, e.g. app_server"
  default = ""
}

variable "aws_resource_assoc" {
  description = "Defines the type of AWS resource that the Security Group is associated with. e.g ec2/rds/elb"
  default = ""
}

variable "auto_update" {
  description = "Defines whether the Security Group should be auto-updated, by lambda, with any new source addresses."
  default = "true"
}

variable "part_of_cluster" {
  description = "Defines whether the Security Group is part of a cluster resource ECS,EKS etc"
  default = "n"
}

variable "maintenance_day" {
  description = "Defines the day of the week that maintenance activities are permitted. mon/tue/wed etc or none"
  default = ""
}

variable "maintenance_time" {
  description = "Defines the time on maintenance_time that maintenance activities are permitted. 24h format, no colon i.e 0400"
  default = ""
}

variable "confidentiality" {
  description = "An identifier for the specific data-confidentiality level a resource supports. public/internal/confidential/highly confidential"
  default = ""
}

variable "compliance" {
  description = "An identifier for workloads designed to adhere to specific compliance requirements. none/pci"
  default = ""
}

variable "aws_resource_assoc" {
  description = "Defines the type of AWS resource that the Security Group is associated with. e.g ec2/rds/elb"
  default = ""
}


