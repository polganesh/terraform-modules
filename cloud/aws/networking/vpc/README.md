This module responsible for creating
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


  
