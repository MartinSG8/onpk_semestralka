output "network_name" {
  value = openstack_networking_network_v2.private_network.name
}

output "subnet_id" {
  value = openstack_networking_subnet_v2.subnet.id
}