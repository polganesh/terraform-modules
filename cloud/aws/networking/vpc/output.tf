
#vpc id
output "id"{
 value="{aws_vpc.main.id}"
}

//list of public subnet ids
output "public_subnets"{
 value="{aws_subnet.public.*.id}"
}

output "privateApp_subnets"{
 value="{aws_subnet.privApp.*.id}"
}

output "privateDb_subnets"{
 value="{aws_subnet.privDb.*.id}"
}