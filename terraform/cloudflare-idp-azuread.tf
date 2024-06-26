resource "cloudflare_access_identity_provider" "azuread" {
  account_id = sensitive(data.sops_file.secrets.data["cloudflare_account_id"])
  name       = "Azure AD"
  type       = "azureAD"

  config {
    client_id      = azuread_application.cloudflare.client_id
    client_secret  = azuread_application_password.cloudflare.value
    directory_id   = data.azuread_client_config.current.tenant_id
    pkce_enabled   = true
    support_groups = true
  }
}
