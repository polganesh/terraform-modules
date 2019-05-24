# This module responsible for creating
- VPC
- 3 Subnets
  - public subnet      :- Place for Load Balancers/API gateway etc.
  - private app subnet :- Place for running backend micro services
  - private DB subnet :- subnet responsible for hosting RDBMS/NoSQL
- Elastic IP 
  -Imp Notes
   - to be associated with Nat gateways
   - total count=total number of Nat Gateways=total number of public subnets
- Nat Gateway
  - Imp Notes
    - responsible for Instances(EC2/Containers etc) in private subnet to communicate with Internet
    - toal number of nat gateways = number of public subnets
    - in AWS subnets dont span across multiple AZ like Azure.
    - Associate public/Elastic IP with each Nat Gateway
- Internet Gateway
  - responsible for enabling traffic with internet
- Route table - for each subnet (public/privateApp/privateDB)
- Route - for each subnet
- VPN gateway - enable on premises network connect to this VPC 


  # Example
 
 ```
  module "vpc"{
	source="git::https://github.com/polganesh/terraform-modules.git//cloud/aws/networking/vpc"
	vpc_cidr_block="10.240.0.0/16"
	public_subnet_cidr_list=["10.240.1.0/24","10.240.2.0/24","10.240.3.0/24"]
	private_app_subnet_list=["10.240.4.0/24","10.240.5.0/24","10.240.6.0/24"]
	private_db_subnet_list=["10.240.7.0/24","10.240.8.0/24","10.240.9.0/24"]
	region="eu-central-1"
	region_id="euc1"
	az_list=["eu-central-1a","eu-central-1b","eu-central-1c"]
	app_role="network"
	vpc_seq_id="001"
	seq_id="001"
	environment="n"
	cost_centre="infra"
	build_date="11052018"
	version_id="001"
}
```

- source - git location of this module on internet
- vpc_cidr_block - CIDR block for VPC
- public_subnet_cidr_list - CIDR for public subnet . responsible for placing load balancer etc
- private_app_subnet_list - CIDR for private subnet. Responsible for application layer
- private_db_subnet_list  - CIDR fo RDS, NOSQL layer
- region - indicates region in which we need to create VPC. default is eu-west-1.
- region_id - short indicator for region. default is euw1.
- az_list - availability zone for region default is  "eu-west-1a","eu-west-1b","eu-west-1c"
- app_role - useful for __tagging__ networking specific resources created by this module
- vpc_seq_id - useful for naming vpc
- seq_id  - useful for sequencing subnet and other components
- environment - default is __dev__
- cost_centre - important tag for determining billing
- build_date - date on which this component last created or updated.
- version_id - incremental number. indicates how many times this component updated. it has to be done manually.


  
