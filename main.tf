variable "diskname" {
  default = ["TS-Dev-App-disk", "TS-Dev-App-datadisk", "TS-Dev-App-logdisk", "TS-Dev-App-osdisk"]
}


resource "azurerm_resource_group" "example" {
  name     = "TS-Dev-App-diskrg"
  location = "East US"
  tags = {
    env = "dev"
    createdby = "TSteam"
  }
}

resource "azurerm_managed_disk" "source" {
    count              = length(var.diskname)
  name                 = var.diskname[count.index]
  location             = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

  tags = {
    env = "dev"
    createdby = "TSteam"
  }
}