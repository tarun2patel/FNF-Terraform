terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.0" # Specify the desired version constraint, for example, "~> 4.0" means version 4.0 or above but less than 5.0.
    }
  }
}

provider "azurerm" {
  features {} # Required block to enable the provider (even if empty).
  # Optional: You can configure various options for authentication and provider behavior here.
  # Examples:
  # subscription_id = "<your_azure_subscription_id>" # Explicitly set the Azure subscription to use.
  # client_id = "<azure_ad_app_id>" # Azure AD app/client ID for authentication.
  # client_secret = "<client_secret_value>" # Secret/password for the client app (consider secure alternatives).
  # tenant_id = "<azure_ad_tenant_id>" # Azure AD tenant ID.
}

resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "West Europe"
}

# Create Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = var.environment == "dev" ? "dev-nsg" : "stage-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Here's where we need the dynamic block
  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range         = "*"
      destination_port_range    = security_rule.value.destination_port_range
      source_address_prefix     = "*"
      destination_address_prefix = "*"
      description               = security_rule.value.description
    }
  }
}

# Output the security rules
output "security_rules" {
  value = azurerm_network_security_group.example.security_rule
}  

