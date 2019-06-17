# get reference of aws VPC which contains name as value of <cost_centre>-<vpc_seq_id>
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc-${var.region_id}*-${var.cost_centre}-${var.vpc_seq_id}"]
  }
}


# get reference of subnet which contains name as privDb
data "aws_subnet_ids" "private_db_subnets" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Name = "*-privDb-*"
  }
}



resource "aws_db_subnet_group" "main" {
  name       = "dbsg-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id}"
  subnet_ids = ["${data.aws_subnet_ids.private_db_subnets.ids}"]

  tags {
    Name        = "dbsg-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                            # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}

resource "random_string" "random" {
  length = 5
  special = false
  upper	= false
}

# A DB instance can contain multiple user-created databases.
resource "aws_db_instance" "main" {
  # depends_on			= ["aws_security_group.default"]

  # ---- db basic details
  engine               	= "${var.db_engine_name}"
  engine_version       	= "${var.db_engine_version}"
  name     				= "rds${var.region_id}${var.environment}${var.cost_centre}vpc${var.vpc_seq_id}${var.app_service}${var.seq_id}"
  identifier			= "rds${var.region_id}${var.environment}${var.cost_centre}vpc${var.vpc_seq_id}${var.app_service}${var.seq_id}"
  final_snapshot_identifier="snp${var.region_id}${var.environment}${var.cost_centre}vpc${var.vpc_seq_id}${var.app_service}${var.seq_id}${random_string.random.result}"
  username             	= "${var.db_user_name}"
  password             	= "${var.db_user_password}"
  # ---- db storage details 
  allocated_storage    	= "${var.db_storage_gibibytes}"
  storage_type         	= "${var.db_storage_type}"
  instance_class       	= "${var.db_instance_class}"

  # ---- version  changes
  # Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible.
  allow_major_version_upgrade 	="${var.allow_major_version_upgrade}"
  #  using apply_immediately can result in a brief downtime as the server reboots.
  apply_immediately           	="${var.apply_immediately}" 
  #  Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true.
  auto_minor_version_upgrade	="${var.auto_minor_version_upgrade}" 
  
  # ---- backup maintenance 
  # The days to retain backups for. Must be between 0 and 35. When creating a Read Replica the value must be greater than 0
  backup_retention_period = "${var.backup_retention_period}"
  # The daily time range (in UTC) during which automated backups are created if they are enabled. Example: "09:46-10:16". Must not overlap with maintenance_window.
  backup_window = "${var.backup_window}"
  
  db_subnet_group_name = "${aws_db_subnet_group.main.id}"
  deletion_protection = "${var.deletion_protection}"
  
  tags {
    Name        = "rds${var.region_id}${var.environment}${var.cost_centre}vpc${var.vpc_seq_id}${var.app_service}${var.seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                            # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
  
  #enabled_cloudwatch_logs_exports
  #final_snapshot_identifier
  #maintenance_window
  #monitoring_interval
  #monitoring_role_arn
  # multi_az

}