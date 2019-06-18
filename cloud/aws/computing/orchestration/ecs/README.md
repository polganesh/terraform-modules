# README #
Initial Ideas for creating this module from 
https://github.com/terraform-community-modules/tf_aws_ecs

## Capabilities of this module ##
it will create
- IAM 
  - role - to allow
    - ecs
    - ec2
  - instance profile - attach role created in earlier step
- Elastic Container Service in VPC with its name  ends with __<cost_centre>-<vpc_seq_id>__ inside subnet with name contains __privApp__ 
- AWS Launch Configuration - useful for configuring EC2 inside ECS
- AWS Auto Scaling Group - useful for scale up/down based on load on the system
- Auto scaling policy (with cooldown period of 5 minutes i.e. 300 seconds) for
  - scale up 
    - add one more EC2 instance if CPU utilization is greater than 80 percent for more than 300 seconds
  - scale down
    - remove one EC2 instance if CPU utilization is less than 30 percent for more than 300 seconds

## To Do
- Monitoring with cloud watch/datadog etc
- Integration with ALB
- housekeeping activity for IAM role etc