# Guardamos la configuración de la máquina virtual en este archivo vm.tf

# IP pública estática
resource "azurerm_public_ip" "public_ip" {
    name                = "pip-asr-terraform"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Static"
    sku                 = "Standard"
}

# Interfaz de red que conecta la VM a la subnet (le asigna la IP pública)
resource "azurerm_network_interface" "nic" {
    name                = "nic-asr-terraform"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.subnet.id
        # La IP privada dentro de la subnet se asigna automáticamente
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.public_ip.id
    }
}

# Máquina virtual Linux (Ubuntu 22.04 LTS)
resource "azurerm_linux_virtual_machine" "vm" {
    name                = "vm-asr-terraform"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    # Tamaño mínimo: 1 vCPU, 1GB RAM
    size                = "Standard_B2as_v2"    
    admin_username      = "adminuser"

    # Asociamos la interfaz de red definida arriba
    network_interface_ids = [
        azurerm_network_interface.nic.id
    ]

    # Autenticación por clave SSH
    admin_ssh_key {
        username   = "adminuser"
        # Clave pública generada localmente con ssh-keygen
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    # Imagen del sistema operativo: Ubuntu Server 22.04 LTS
    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }
}