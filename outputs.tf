output "ip_publica" {
    description = "IP pública de la máquina virtual"
    value       = azurerm_public_ip.public_ip.ip_address
}

output "ssh_connection" {
    description = "Comando para conectarse a la VM por SSH"
    value       = "ssh adminuser@${azurerm_public_ip.public_ip.ip_address}"
}

