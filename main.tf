resource "azurerm_public_ip" "vm_pip" {
  name 				= "vm-pip"
  location 			= "${var.location}"
  resource_group_name 		= "${azurerm_resource_group.terraform_rg.name}"
  public_ip_address_allocation 	= "static"
}

resource "azurerm_network_interface" "public_nic" {
  name 		      = "vm-nic"
  location 	      = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_rg.name}"

  ip_configuration {
    name 			= "vm-nic-ip"
    subnet_id 			= "${azurerm_subnet.subnet_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id	= "${azurerm_public_ip.vm_pip.id}"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "vm-server-1"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.public_nic.id}"]
  vm_size               = "Standard_B2s"

  #This will delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "osdisk-1"
    vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.storage.name}/osdisk-1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "vm-server-1"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  connection {
      type     = "ssh"
      host     = "${azurerm_public_ip.vm_pip.ip_address}"
      user     = "${var.vm_username}"
      password = "${var.vm_password}"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /tmp",
      "curl -o bootstrap-salt.sh -L https://bootstrap.saltstack.com",
      "sudo sh bootstrap-salt.sh",
      "sudo salt-call --version"
    ]
  }

}