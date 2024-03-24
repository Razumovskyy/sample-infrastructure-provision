# gateway server with public ip
# nginx load balancer for django backend applications

# Create a network boot disk from the image
resource "openstack_blockstorage_volume_v3" "nginx_volume" {
  count                = 2
  name                 = "volume-for-nginx-server${count.index + 1}"
  size                 = "10"
  image_id             = data.openstack_images_image_v2.ubuntu_image.id
  volume_type          = var.volume_type
  availability_zone    = var.az_zone
  enable_online_resize = true
  lifecycle {
    ignore_changes = [image_id]
  }
}

# Creating an instance
resource "openstack_compute_instance_v2" "nginx_server" {
  count             = 2
  name              = count.index == 0 ? "beta_gateway" : "beta_lb_apps"
  flavor_id         = openstack_compute_flavor_v2.flavor_nginx.id
  key_pair          = openstack_compute_keypair_v2.key_tf.id
  availability_zone = var.az_zone
  network {
    uuid = var.beta_network
  }
  block_device {
    uuid             = openstack_blockstorage_volume_v3.nginx_volume[count.index].id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }
  vendor_options {
    ignore_resize_confirmation = true
  }
  lifecycle {
    ignore_changes = [image_id]
  }
}

# Linking public IP to the instance
resource "openstack_compute_floatingip_associate_v2" "fip_tf" {
  floating_ip = openstack_networking_floatingip_v2.fip_for_beta_gateway.address
  instance_id = openstack_compute_instance_v2.nginx_server[0].id
}

resource "openstack_networking_floatingip_v2" "fip_for_beta_gateway" {
  pool = "external-network"
}
