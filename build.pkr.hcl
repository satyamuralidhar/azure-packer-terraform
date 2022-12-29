source "azure-arm" "packer-image" {
  client_id = var.client_id
  client_secret = var.client_secret
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  resource_group_name = var.resource_group_name
  storage_account = var.storage_account

  capture_container_name = "images"
  capture_name_prefix = "packer"

  os_type = "Linux"
  image_publisher = "RedHat"
  image_offer = "RHEL"
  image_sku = "79-gen2-latest"


  location = var.location
  vm_size = "Standard_B1s"
}

build {
    sources = [
        "source.azure-arm.packer-image"
    ]
    provisioner "shell" {
        inline = [
            "sudo chmod +x tomcat/tomcat.sh",
            "sudo sh tomcat/tomcat.sh"
        ]
    }
}
