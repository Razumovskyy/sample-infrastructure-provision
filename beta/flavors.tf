# The parameter disk = 0 makes the network disk bootable

# Can't add "description" argument to the falvor block, because of Selectel policies

# 'main-flavor' -- for most servers
# 'nginx-flavor' -- light flavor for nginx proxies

resource "openstack_compute_flavor_v2" "flavor_server" {
  name      = "main-flavor"
  ram       = "2048"
  vcpus     = "2"
  disk      = "0"
  is_public = "false"
}

resource "openstack_compute_flavor_v2" "flavor_nginx" {
  name      = "nginx-flavor"
  ram       = "1024"
  vcpus     = "1"
  disk      = "0"
  is_public = "false"
}


resource "openstack_compute_flavor_v2" "flavor_iot" {
  name      = "iot-flavor"
  ram       = "1024"
  vcpus     = "1"
  disk      = "0"
  is_public = "false"
}