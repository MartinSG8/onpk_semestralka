# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

# --- <network&subnet> ---
resource "openstack_networking_network_v2" "private_network_1" {
  name           = "private_network_1"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name       = "subnet_1"
  network_id = openstack_networking_network_v2.network_1.id
  cidr       = "192.168.1.0/24"
  ip_version = 4
}
# --- <!network&subnet!> ---

# --- <security_group&security_group_rule> ---
resource "openstack_networking_secgroup_v2" "public_secgroup_1" {
  name        = "public_secgroup_1"
  description = "Security group for public instance"
}

resource "openstack_networking_secgroup_rule_v2" "public_secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_v2" "private_secgroup_1" {
  name        = "private_secgroup_1"
  description = "Security group for public instance"
}

resource "openstack_networking_secgroup_rule_v2" "private_secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}
# --- <!security_group&security_group_rule!> ---