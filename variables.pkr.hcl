# variable "client_id" {}
# variable  "client_secret" {}
# variable "subscription_id" {}
# variable "tenant_id" {}
variable "resource_group_name" {}
variable "storage_account" {}
variable "location" {}




#packer build -var client_id="$client_id" -var client_secret="$client_secret" -var subscription_id="$subscription_id" -var tenant_id="tenant_id"