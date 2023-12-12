# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

# --- <network&subnet> ---
resource "openstack_networking_network_v2" "private_network" {
  name           = var.private_network_name
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = join("_", [var.private_network_name, "subnet"])
  network_id = openstack_networking_network_v2.private_network.id
  cidr       = var.private_subnet
  ip_version = 4
}
# --- <!network&subnet!> ---