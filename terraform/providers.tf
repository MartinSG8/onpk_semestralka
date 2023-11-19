# --- <providers.tf> ---

# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

provider "openstack" {
  user_name          = var.username
  password           = var.password
  tenant_name        = var.tenant_name
  auth_url           = local.kis_os_auth_url
  region             = local.kis_os_region
  insecure           = true
  endpoint_overrides = local.kis_os_endpoint_overrides
  domain_name        = local.domain_name
}

# --- </providers.tf> ---


# --- <variables.tf> ---

variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "tenant_name" {
  type = string
}

variable "flavor_name" {
  type    = string
  default = "ONPK_small"
}

variable "environment" {
  type    = string
  default = "dev"
}

# --- </variables.tf> ---

# --- <locals.tf> ---

locals {
  kis_os_region   = "RegionOne"
  kis_os_auth_url = "https://158.193.152.44:5000/v3/"

  kis_os_endpoint_overrides = {
    compute = "https://158.193.152.44:8774/v2.1/"
    image   = "https://158.193.152.44:9292/v2.0/"
    network = "https://158.193.152.44:9696/v2.0/"
  }
  domain_name = "admin_domain"
  # my_public_ip = "${data.http.my_public_ip.response_body}/32"
  # project      = lower("${var.tenant_name}-docker")
}

# --- </locals.tf> ---
