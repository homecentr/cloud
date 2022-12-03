resource "azuread_application" "proxmox" {
  display_name     = "Proxmox VE${var.display_name_environment_suffix}"
  sign_in_audience = "AzureADMyOrg"

  web {
    redirect_uris = var.proxmox_urls
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    # offline_access and openid scopes
    resource_access {
      id   = "37f7f235-527c-4136-accd-4a02d197296e"
      type = "Scope"
    }

    resource_access {
      id   = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182"
      type = "Scope"
    }
  }

  api {
    requested_access_token_version = "2"
  }
}

resource "azuread_application_pre_authorized" "proxmox" {
  application_object_id = "00000003-0000-0000-c000-000000000000"
  authorized_app_id     = azuread_application.proxmox.application_id
  permission_ids        = ["37f7f235-527c-4136-accd-4a02d197296e", "7427e0e9-2fba-42fe-b0c0-848c9e6a8182"]
}
