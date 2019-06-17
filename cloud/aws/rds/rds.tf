variable "db_user_name"{
}
variable "db_user_password"{
}



module "rds"{
	source="../../../../../../terraform-modules/cloud/aws/database/rds"
	
	db_engine_name="mysql"
	db_engine_version="5.7"
	db_user_name= "${var.db_user_name}"
	db_user_password  ="${var.db_user_password}"
	db_storage_gibibytes="20"
	db_storage_type= "gp2"
	db_instance_class ="db.t2.micro"
	allow_major_version_upgrade=false
	apply_immediately=false
	auto_minor_version_upgrade=true
	backup_retention_period=2
	# The daily time range (in UTC) during which automated backups are created if they are enabled. 
	# Example: "09:46-10:16". Must not overlap with maintenance_window.
	# UTC is 2 hours behind berlin time (CET)
	backup_window= "09:46-10:16"
	deletion_protection="false"

	# db_subnet_ids="${data.aws_subnet_ids.private_db_subnets.ids}"
	vpc_seq_id="001"
	seq_id="001"
	
	region="eu-central-1" 
	region_id="euc1"
	environment="dev"
	cost_centre="infra"
	build_date="11072019"
	version_id="001"
	app_service="poc"
}
