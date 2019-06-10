resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.location_id}-${var.environment}-${var.cost_centre}-${var.seq_id}"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  address_space       = "${var.vnet_cidr_list}"
}

resource "azurerm_subnet" "aks" {
  name                 = "subnet-aks-${var.location_id}-${var.environment}-${var.cost_centre}-${var.seq_id}"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  address_prefix       = "${var.subnet_aks_cidr}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
}

resource "azurerm_subnet" "gateway-subnet" {
  name="GatewaySubnet"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  address_prefix       = "${var.subnet_gateway_cidr}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
}

resource "azurerm_subnet" "api-gateway-subnet" {
  name="api-gateway"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  address_prefix       = "${var.api_gateway_subnet_cidr}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
}


