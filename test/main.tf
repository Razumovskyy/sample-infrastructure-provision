terraform {
  required_version = ">= 1.5.0"
  required_providers {
    openstack = {
        source = "terraform-provider-openstack/openstack"
        version = "~> 1.53.0"
    }
  }
}

# Initializing the OpenStack Provider
provider "openstack" {
  auth_url = "https://cloud.api.selcloud.ru/identity/v3"
  domain_name = var.domain_name
  tenant_id = var.tenant_id
  user_name = var.user_name
  password = var.password
  region = var.region
}

# Creating SSH-key
resource "openstack_compute_keypair_v2" "key_tf" {
    name = "key_tf"
    region = var.region
    public_key = var.public_key
}

# Fetching the external network
data "openstack_networking_network_v2" "external_net" {
  name = "external-network"
}

# Fetching Ubuntu image
data "openstack_images_image_v2" "ubuntu_image" {
  most_recent = true
  visibility  = "public"
  name        = "Ubuntu 22.04 LTS 64-bit"
}
