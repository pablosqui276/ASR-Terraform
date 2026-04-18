# Iteramos por la lista de nombres de VM para mostrar las IPs y los comandos ssh
output "ips_por_vm" {
  value = {
    for name in var.vm_names :
    name => azurerm_public_ip.public_ip[name].ip_address
  }
}

output "ssh_commands" {
  value = {
    for name in var.vm_names :
    name => "ssh adminuser@${azurerm_public_ip.public_ip[name].ip_address}"
  }
}