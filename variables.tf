variable "location" {
  description = "Región de Azure"
  default     = "Sweden_Central"
}

variable "resource_group_name" {
  default = "rg-tfstate"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_address_space" {
  default = ["10.0.1.0/24"]
}