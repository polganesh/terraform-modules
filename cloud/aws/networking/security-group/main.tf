/**
Module Name :- Amazon Security Group
Description	:- Security group. for more information and how to use this module refer readme file for this.
**/

##########################
##### Security Group #####
##########################
# get reference of aws VPC which contains name as value of <cost_centre>-<vpc_seq_id>
data "aws_vpc" "vpc" {
   filter {
    name   = "tag:Name"
    values = ["vpc-${var.region_id}*-${var.cost_centre}-${var.vpc_seq_id}"]
  }
}


resource "aws_security_group" "securitygroup" {
	name        = "sgr-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}${var.sg_for}-${var.seq_id}"
	description = "${var.sg_description}"
	vpc_id      = "${data.aws_vpc.vpc.id}"
	
	tags {
		# generic tags
		Name        = "sgr-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}${var.sg_for}-${var.seq_id}"
		RegionId	="${var.region_id}"
		Environment = "${var.environment}"
		CostCentre	="${var.cost_centre}"
		VPCSeqId	="${var.vpc_seq_id}"
		VersionId	="${var.version_id}" # this is indication of version. for each change it is better to incr this value
		BuildDate	="${var.build_date}"
		AppRole		="${var.app_role}"
		AppService	="${var.app_service}"
		MaintenanceDay= "${var.maintenance_day}"
		MaintenanceTime= "${var.maintenance_time}"
		Confidentiality= "${var.confidentiality}"
		Compliance = "${var.compliance}"
		
		#specific to security group
		AutoUpdate  ="${var.auto_update}"
		PartOfCluster= "${var.part_of_cluster}"
		AWSResourceAssoc= "${var.aws_resource_assoc}"
	}
}


