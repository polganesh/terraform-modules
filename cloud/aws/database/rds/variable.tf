# variable "db_subnet_ids"{
#	type        = "list"
#	description = "Possible placement of RDS in specific subnets"
#
#}

variable "db_engine_name" {
  default 		= "mysql"
  description	="identifier for engine.default is mysql "
}

variable "db_engine_version" {
  default 		= "5.7"
}

variable "region_id" {
  default = "euw1"
}

variable "environment" {
  description = "indicates name of our environment. possible values dev,cit,sit,uat,pprod,prod,n"
  default     = "dev"
}

variable "cost_centre" {
  description = "A part of an organization to which costs may be charged.e.g. finance/it/hr/wholesale/retail/investment etc..."
  default     = ""
}

variable "vpc_seq_id" {
  description = "seq of vpc in which this RDS present."
  default     = ""
}

variable "version_id" {}
variable "build_date" {}
variable "app_service" {}

variable "seq_id" {}
variable "db_user_name" {}
variable "db_user_password" {}
variable "db_storage_gibibytes" {}
variable "db_storage_type" {}
variable "db_instance_class" {}
variable "app_role" {default="rds"}


# useful if need to add tag
variable "region" {
  description = "region in which resource is created."
  default     = "eu-west-1"
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  default     = "false"
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false."
  default     = "false"
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true."
  default     = "true"
}

variable "backup_retention_period" {
 default     = "0"
}

variable "deletion_protection" {
 default="false"
}

variable "backup_window"{
}



