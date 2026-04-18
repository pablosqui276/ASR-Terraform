variable "location" {
  description = "Región de Azure"
  default     = "spaincentral"
}

variable "resource_group_name" {
  default = "rg-asr-terraform"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_address_space" {
  default = ["10.0.1.0/24"]
}