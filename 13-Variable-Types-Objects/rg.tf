# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "rg" {
  #name = var.resource_group_name
  name     = "${var.business_unit}-${var.environment}-${var.resoure_group_name}"
  location = var.resoure_group_location
  tags     = var.common_tags
}