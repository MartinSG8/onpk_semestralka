module "network" {
  source = "./modules/network"
  private_subnet = "192.168.1.0/24"
  private_network_name = "private_network"
}

module "compute" {
  source = "./modules/compute"
  remote_prefix = "158.193.0.0/16"
  public_key_name = "onpk_keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnTiDgucESGAd8FUG/tRfAseHoQHLYImf3u134Zm69Thpr6vLqJbjg15Y0pv1OOHQg30QhB7MKYAcp5PDTimZ1mxRO6w1RMfzDvwJRKJI8Odz8BTbPSqw6swTM8VE0cTyf8qmYvbsESmLkOYBMMuvql6U4czmbTZ55KpPYT4C9KdT90vxu+S+dpcXR/GdJxifsc7jH++6Gi7bfoJAtRXCb2gkmV3pMrVwFYyPYrnslJVN/O+DpnLcXS/DD0CYJQUR7yi3RmnONM8zKS3XrJpLAQcF2ecvevmBhhmaTe+/U4DhW45KP/OlRh/ZzTePedAHlUEgf4UL6p983JR1ZUipZ"
  jumpbox_name = "jump_box"
  jump_box_image_id = "df3c4dc8-6a1e-4e5c-8a52-afe5112e06d0"
  jump_box_flavor_name = "2c2r20d"
  ext_inet = "ext-net-154"
  private_network_name = module.network.network_name
  compute_name = "k8s_instance"
  compute_image_id = "df3c4dc8-6a1e-4e5c-8a52-afe5112e06d0"
  compute_flavor_name = "4c4r40d"
}