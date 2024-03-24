# Create a network boot disk from the image
resource "openstack_blockstorage_volume_v3" "volume_server" {
  count                = 3
  name                 = "volume-for-backend-server${count.index + 1}"
  size                 = "30"
  image_id             = data.openstack_images_image_v2.ubuntu_image.id
  volume_type          = var.volume_type
  availability_zone    = var.az_zone
  enable_online_resize = true
  lifecycle {
    ignore_changes = [image_id]
  }
}

# Creating an instance
resource "openstack_compute_instance_v2" "server_tf" {
  count             = 3
  name              = "test_backend_${count.index + 1}"
  flavor_id         = openstack_compute_flavor_v2.flavor_server.id
  key_pair          = openstack_compute_keypair_v2.key_tf.id
  availability_zone = var.az_zone
  network {
    uuid = var.network_uuid
  }
  block_device {
    uuid             = openstack_blockstorage_volume_v3.volume_server[count.index].id
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
