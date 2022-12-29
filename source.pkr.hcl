source "azure-arm" "packer-image" {
  client_id                         = var.client_id
  client_secret                     = var.client_secret
  subscription_id                   = var.subscription_id
  tenant_id                         = var.tenant_id
  os_type                           = "Linux"
  image_publisher                   = "RedHat"
  image_offer                       = "RHEL"
  image_sku                         = "79-gen2"
  location                          = var.location
  vm_size                           = "Standard_B1s"
  managed_image_resource_group_name = var.resource_group_name
  managed_image_name                = "packerterrform01"
}

build {
  sources = [
    "source.azure-arm.packer-image"
  ]
  provisioner "shell" {
    inline = [
      "sudo yum install java-1.8.0-openjdk-devel -y",
      "sudo yum install tomcat -y",
      "sudo service tomcat restart",
      "sudo service tomcat status",
      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ]
    inline_shebang = "/bin/sh -x"
  }

}
