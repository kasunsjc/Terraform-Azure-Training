# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "linuxvm" {
  for_each              = var.environment
  name                  = "mylinuxvm-${each.key}"
  computer_name         = "${var.business_unit}-${each.key}" # Hostname of the VM
  resource_group_name   = azurerm_resource_group.rg[each.key].name
  location              = azurerm_resource_group.rg[each.key].location
  size                  = "Standard_DS1_v2"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.vmnic[each.key].id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
  }

  os_disk {
    name                 = "osdisk${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app-scripts/app1-cloud-init.txt")
}


