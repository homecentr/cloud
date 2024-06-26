resource "azuread_application" "pomerium" {
  display_name     = "Pomerium"
  sign_in_audience = "AzureADMyOrg"
  logo_image       = filebase64("../icons/pomerium.png")

  web {
    redirect_uris = var.pomerium_redirect_urls
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read.All"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["Group.Read.All"]
      type = "Scope"
    }

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["Directory.Read.All"]
      type = "Scope"
    }
  }

  optional_claims {
    access_token {
      name = "groups"
    }

    id_token {
      name = "groups"
    }

    saml2_token {
      name = "groups"
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

resource "azuread_service_principal" "pomerium" {
  client_id                    = azuread_application.pomerium.client_id
  app_role_assignment_required = true

  owners = [
    data.azuread_user.admin.object_id
  ]

  feature_tags {
    enterprise = true
  }
}

# Admin level consent for the required scopes
resource "azuread_service_principal_delegated_permission_grant" "pomerium" {
  service_principal_object_id          = azuread_service_principal.pomerium.object_id
  resource_service_principal_object_id = azuread_service_principal.msgraph.object_id
  claim_values                         = ["User.Read", "User.Read.All", "Group.Read.All", "Directory.Read.All"]
}

# Assign the app to the Administrators group
resource "azuread_app_role_assignment" "pomerium_administrators" {
  app_role_id         = "00000000-0000-0000-0000-000000000000" # Default access
  principal_object_id = azuread_group.administrators.object_id
  resource_object_id  = azuread_service_principal.pomerium.object_id
}

# Assign the app to the Users group
resource "azuread_app_role_assignment" "pomerium_users" {
  app_role_id         = "00000000-0000-0000-0000-000000000000" # Default access
  principal_object_id = azuread_group.users.object_id
  resource_object_id  = azuread_service_principal.pomerium.object_id
}
