# Create a REsource Group
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
}