/**
Module Name :- Amazon VPC
Description	:- General Purpose VPC. for more information and how to use this module refer readme file for this.
**/
resource "aws_vpc" "main" {
  cidr_block                       = "${var.vpc_cidr_block}"
  instance_tenancy                 = "${var.vpc_instance_tenancy}"
  assign_generated_ipv6_cidr_block = "${var.assign_ipv6_cidr_block}"

  tags {
    Name        = "vpc-${var.region_id}-${var.environment}-${var.cost_centre}-${var.vpc_seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                            # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(var.public_subnet_cidr_list, count.index)}"
  count                   = "${length(var.public_subnet_cidr_list)}"
  availability_zone       = "${element(var.az_list, count.index)}"
  map_public_ip_on_launch = "true"

  tags {
    Name        = "sub-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-pub-${element(split("-",element(var.az_list,count.index)),2)}-${var.seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                                                                                                           # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}

resource "aws_subnet" "privApp" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.private_app_subnet_list, count.index)}"
  count             = "${length(var.private_app_subnet_list)}"
  availability_zone = "${element(var.az_list, count.index)}"

  tags {
    Name        = "sub-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-privApp-${element(split("-",element(var.az_list,count.index)),2)}-${var.seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                                                                                                               # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}

resource "aws_subnet" "privDb" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.private_db_subnet_list, count.index)}"
  count             = "${length(var.private_db_subnet_list)}"
  availability_zone = "${element(var.az_list, count.index)}"

  tags {
    Name        = "sub-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-privDb-${element(split("-",element(var.az_list,count.index)),2)}-${var.seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                                                                                                              # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}

###################------Gateway------#################
#Internet gateway 	:-	enable traffic with internet and viceaversa
#Nat gateway 		:-	enable resources in private subnet 
#						to communicate on internet 
#						but reverse is not true
#######################################################
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
  count  = 1

  tags {
    Name        = "igw-${var.region_id}-${var.environment}-${var.cost_centre}-${var.vpc_seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                            # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}

# these elastic Ip we will associate with nat gateway associated with each private subnet
resource "aws_eip" "main" {
  count = "${length(var.private_app_subnet_list)}"
  vpc   = true                                     #indicates if this elastic ip in VPC
}

# create nat gateway in each public subnet and allocate elastic ip to it.
# this will used for instances in private subnet to connect internet
resource "aws_nat_gateway" "main" {
  count         = "${length(var.private_app_subnet_list)}"
  allocation_id = "${element(aws_eip.main.*.id,count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.gw"]

  tags {
    Name        = "ngw-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${element(split("-",element(var.az_list,count.index)),2)}-${var.seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                                                                                                       # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}

######################################################
# Route table and route association
######################################################
resource "aws_route_table" "public" {
  vpc_id           = "${aws_vpc.main.id}"
  count            = "${length(var.public_subnet_cidr_list)}"
  propagating_vgws = ["${aws_vpn_gateway.main.id}"]

  tags {
    Name        = "rtb-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-public-${element(split("-",element(var.az_list,count.index)),2)}-${var.seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                                                                                                              # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}

resource "aws_route" "public" {
  count                  = "${length(var.public_subnet_cidr_list)}"
  route_table_id         = "${element(aws_route_table.public.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

#------private app
resource "aws_route_table" "privateApp" {
  vpc_id           = "${aws_vpc.main.id}"
  count            = "${length(var.private_app_subnet_list)}"
  propagating_vgws = ["${aws_vpn_gateway.main.id}"]

  tags {
    Name        = "rtb-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-privApp-${element(split("-",element(var.az_list,count.index)),2)}-${var.seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                                                                                                               # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}

resource "aws_route" "privateApp" {
  count                  = "${length(var.private_app_subnet_list)}"
  route_table_id         = "${element(aws_route_table.privateApp.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.main.*.id, count.index)}"
}

#------private db
resource "aws_route_table" "privateDb" {
  vpc_id           = "${aws_vpc.main.id}"
  count            = "${length(var.private_db_subnet_list)}"
  propagating_vgws = ["${aws_vpn_gateway.main.id}"]

  tags {
    Name        = "rtb-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-privDb-${element(split("-",element(var.az_list,count.index)),2)}-${var.seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                                                                                                              # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}

resource "aws_route" "privateDb" {
  count                  = "${length(var.private_db_subnet_list)}"
  route_table_id         = "${element(aws_route_table.privateDb.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.main.*.id, count.index)}"
}

#--------route table associatation with subnet
resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnet_cidr_list)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
}

resource "aws_route_table_association" "privateApp" {
  count          = "${length(var.private_app_subnet_list)}"
  subnet_id      = "${element(aws_subnet.privApp.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.privateApp.*.id, count.index)}"
}

resource "aws_route_table_association" "privateDb" {
  count          = "${length(var.private_db_subnet_list)}"
  subnet_id      = "${element(aws_subnet.privDb.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.privateDb.*.id, count.index)}"
}

######################################################
# VPN Gateway
######################################################
resource "aws_vpn_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "vpngw-${var.region_id}-${var.environment}-${var.cost_centre}-${var.vpc_seq_id}"
    RegionId    = "${var.region_id}"
    Environment = "${var.environment}"
    CostCentre  = "${var.cost_centre}"
    VPCSeqId    = "${var.vpc_seq_id}"
    VersionId   = "${var.version_id}"                                                              # this is indication of version. for each change it is better to incr this value
    BuildDate   = "${var.build_date}"
    AppRole     = "${var.app_role}"
  }
}
