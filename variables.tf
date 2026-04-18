variable "location" {
  description = "Región de Azure"
  default     = "polandcentral"
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

variable "vm_names" {
  description = "Lista de nombres de máquinas virtuales"
  type        = list(string)

  default = [
    "control-node",
    "vm1-web",
    "vm2-db",
    "vm3-extra"
  ]
}