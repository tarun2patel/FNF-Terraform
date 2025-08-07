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
