variable "environment"{
	description="indicates name of our environment. possible values dev,cit,sit,uat,pprod,prod,n"
	default="dev"
}

variable "cost_centre"{
	description="A part of an organization to which costs may be charged.e.g. finance/it/hr/wholesale/retail/investment etc..."
	default=""
}
variable "vpc_cidr_block"{}

variable "vpc_instance_tenancy" {
	default="default" 
	description="possible values default or dedicated"
}

variable "assign_ipv6_cidr_block"{
	default="false" 
}

variable "region_id"{
	default="euw1"
}

variable "region"{
	description="region in which resource is created."
	default="eu-west-1"
}

variable "version_id"{
	description="version of this component.everytime when we are updating this component we need to increment it."
	default=""
}

variable "build_date"{
	description="date on which this component built/modified. format ddmmyyyy e.g. 27122017"
	default=""
}

variable "vpc_seq_id"{
}

variable "public_subnet_cidr_list"{
	description="all public facing resources e.g. ALB will reside in this subnet"
	type="list"
}

variable "private_app_subnet_list"{
	description="all backend micro services ECS/K8s etc will receive request from this."
	type="list"
}

variable "private_db_subnet_list"{
	description="all noSQL, RDS etc will reside here"
	type="list"
}

variable "az_list"{
	type="list"
	default=["eu-west-1a","eu-west-1b","eu-west-1c"]
}

variable "seq_id"{}
variable "app_role"{}


