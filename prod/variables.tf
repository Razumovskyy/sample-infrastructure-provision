variable "domain_name" {}
variable "tenant_id" {}
variable "user_name" {}
variable "password" {}
variable "public_key" {}
variable "prod_network" {}
variable "network_uuid" {}

# Пул Облачной платформы
variable "region" {
  default = "ru-2"
}

# Сегмент пула
variable "az_zone" {
  default = "ru-2c"
}

# Тип сетевого диска, из которого создается сервер
variable "volume_type" {
  default = "basic.ru-2c"
}

# CIDR подсети
variable "subnet_cidr" {
  default = "192.168.11.0/24"
}