# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

# --- <security_group> ---
resource "openstack_networking_secgroup_v2" "public_secgroup_1" {
  name        = "public_secgroup_1"
  description = "Security group for public instance"
}

resource "openstack_networking_secgroup_v2" "private_secgroup_1" {
  name        = "private_secgroup_1"
  description = "Security group for private instance"
}
# --- <!security_group!> ---

# --- <security_group_rule> ---
resource "openstack_networking_secgroup_rule_v2" "public_secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.remote_prefix
  security_group_id = openstack_networking_secgroup_v2.public_secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "private_secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.private_secgroup_1.id
}
# --- <!security_group_rule!> ---

# --- <key> ---
resource "openstack_compute_keypair_v2" "keypair" {
  name       = var.public_key_name
  public_key = var.public_key
}
# --- <!key!> ---



#  --- <instances> ---
resource "openstack_compute_instance_v2" "jump_box" {
  name            = var.jumpbox_name
  image_id        = var.jump_box_image_id
  flavor_name     = var.jump_box_flavor_name
  key_pair        = var.public_key_name
  security_groups = ["public_secgroup_1"]
  # user_data = file("scripts/config_jump_box.sh")

  network {
    name = var.ext_inet
  }

  network {
    name = var.private_network_name
  }
}

resource "openstack_compute_instance_v2" "K8s_instance" {
  name            = var.compute_name
  image_id        = var.compute_image_id
  flavor_name     = var.compute_flavor_name
  key_pair        = var.public_key_name
  security_groups = ["default"]

  network {
    name = var.private_network_name
  }
}
#  --- <!instances!> ---
