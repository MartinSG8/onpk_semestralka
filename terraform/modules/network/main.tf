# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

resource "openstack_networking_network_v2" "network_1" {
  name           = "network_1"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name       = "subnet_1"
  network_id = openstack_networking_network_v2.network_1.id
  cidr       = "192.168.1.0/24"
  ip_version = 4
}

resource "openstack_networking_subnet_v2" "subnet_2" {
  name       = "subnet_2"
  network_id = openstack_networking_network_v2.network_1.id
  cidr       = "192.168.2.0/24"
  ip_version = 4
}