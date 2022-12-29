resource "azurerm_resource_group" "myrsg" {
  name     = var.rsg
  location = var.location
}

locals {
  required_tags = {
    Account      = var.tags["Account"]
    Subscription = var.tags["Subscription"]
    Application  = var.tags["Application"]
  }
}


resource "azurerm_storage_account" "mystorage" {
  name                     = lower(var.storage_name)
  resource_group_name      = azurerm_resource_group.myrsg.name
  location                 = azurerm_resource_group.myrsg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.required_tags
  depends_on = [
    azurerm_resource_group.myrsg
  ]
}

# resource "azurerm_shared_image_gallery" "sig" {
#   name = "packer-sig"
#   resource_group_name      = azurerm_resource_group.myrsg.name
#   location                 = azurerm_resource_group.myrsg.location
#   tags = local.required_tags
# }

resource "null_resource" "packer-cmds" {
  provisioner "local-exec" {
    command = "sudo packer build build.pkr.hcl"
  }
  depends_on = [
    azurerm_resource_group.myrsg,
    azurerm_storage_account.mystorage
  ]
}