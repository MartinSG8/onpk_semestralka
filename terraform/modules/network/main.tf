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
  network_id = openstack_networking_network_v2.private_network_1.id
  cidr       = "192.168.1.0/24"
  ip_version = 4
}
# --- <!network&subnet!> ---

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
  remote_ip_prefix  = "158.193.0.0/16"
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
  name       = "onpk_keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnTiDgucESGAd8FUG/tRfAseHoQHLYImf3u134Zm69Thpr6vLqJbjg15Y0pv1OOHQg30QhB7MKYAcp5PDTimZ1mxRO6w1RMfzDvwJRKJI8Odz8BTbPSqw6swTM8VE0cTyf8qmYvbsESmLkOYBMMuvql6U4czmbTZ55KpPYT4C9KdT90vxu+S+dpcXR/GdJxifsc7jH++6Gi7bfoJAtRXCb2gkmV3pMrVwFYyPYrnslJVN/O+DpnLcXS/DD0CYJQUR7yi3RmnONM8zKS3XrJpLAQcF2ecvevmBhhmaTe+/U4DhW45KP/OlRh/ZzTePedAHlUEgf4UL6p983JR1ZUipZ"
}
# --- <!key!> ---

#  --- <instances> ---
resource "openstack_compute_instance_v2" "jump_box" {
  name            = "jump_box"
  image_id        = "df3c4dc8-6a1e-4e5c-8a52-afe5112e06d0"
  flavor_name = "2c2r20d"
  key_pair        = "onpk_keypair"
  security_groups = ["public_secgroup_1"]
  user_data = file("./scripts/config_jump_box.sh")

  network {
    name = "ext-net-154"
  }

  network {
    name = "private_network_1"
  }
}

resource "openstack_compute_instance_v2" "K8s_instance" {
  name            = "K8s_instance"
  image_id        = "df3c4dc8-6a1e-4e5c-8a52-afe5112e06d0"
  flavor_name = "4c4r40d"
  key_pair        = "onpk_keypair"
  security_groups = ["default"]

  network {
    name = "private_network_1"
  }
}
#  --- <!instances!> ---