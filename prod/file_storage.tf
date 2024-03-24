# To operate with shared file storages you need to create share_type. To do that you need to install manila client
# Before you install and configure the Shared File Systems service, you must create a database, service credentials, and API endpoints. 

# resource "openstack_sharedfilesystem_share_v2" "share_1" {
#   name             = "nfs_share"
#   description      = "test share description"
#   share_proto      = "NFS"
#   size             = 1
#   availability_zone = var.az_zone
#   share_type = ""
# }