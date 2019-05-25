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

variable "vpc_seq_id"{}
