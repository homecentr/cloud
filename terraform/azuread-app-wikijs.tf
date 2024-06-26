resource "azuread_application" "wikijs" {
  display_name     = "Wiki.js"
  sign_in_audience = "AzureADMyOrg"
  logo_image       = filebase64("../icons/wikijs.png")

  web {
    redirect_uris = var.wikijs_redirect_urls

    implicit_grant {
      id_token_issuance_enabled = true
    }
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

    # offline_access and openid scopes
    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["email"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["openid"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["offline_access"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"]
      type = "Scope"
    }
  }

  optional_claims {
    access_token {
      name = "email"
    }

    access_token {
      name = "groups"
    }

    access_token {
      name = "preferred_username"
    }

    id_token {
      name = "email"
    }

    id_token {
      name = "groups"
    }

    id_token {
      name = "preferred_username"
    }
  }

  group_membership_claims = ["SecurityGroup", "ApplicationGroup"]

  api {
    requested_access_token_version = "2"
  }

  feature_tags {
    enterprise = true
    gallery    = false
  }
}

resource "azuread_service_principal" "wikijs" {
  client_id                    = azuread_application.wikijs.client_id
  app_role_assignment_required = true

  owners = [
    data.azuread_user.admin.object_id
  ]

  feature_tags {
    enterprise = true
  }
}

# Admin level consent for the required scopes
resource "azuread_service_principal_delegated_permission_grant" "wikijs" {
  service_principal_object_id          = azuread_service_principal.wikijs.object_id
  resource_service_principal_object_id = azuread_service_principal.msgraph.object_id
  claim_values                         = ["email", "openid", "offline_access", "User.Read", "User.Read.All", "Group.Read.All", "Directory.Read.All"]
}

# Assign the app to the Administrators group
resource "azuread_app_role_assignment" "wikijs_administrators" {
  app_role_id         = "00000000-0000-0000-0000-000000000000" # Default access
  principal_object_id = azuread_group.administrators.object_id
  resource_object_id  = azuread_service_principal.wikijs.object_id
}

resource "azuread_app_role_assignment" "wikijs_users" {
  app_role_id         = "00000000-0000-0000-0000-000000000000" # Default access
  principal_object_id = azuread_group.users.object_id
  resource_object_id  = azuread_service_principal.wikijs.object_id
}
