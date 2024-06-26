resource "cloudflare_access_policy" "administrators" {
  account_id = sensitive(data.sops_file.secrets.data["cloudflare_account_id"])
  name       = "AD Group / ${azuread_group.administrators.display_name}"
  decision   = "allow"

  include {
    azure {
      identity_provider_id = cloudflare_access_identity_provider.azuread.id

      id = [
        azuread_group.administrators.object_id
      ]
    }
  }
}

resource "cloudflare_access_policy" "users" {
  account_id = sensitive(data.sops_file.secrets.data["cloudflare_account_id"])
  name       = "AD Group / ${azuread_group.users.display_name}"
  decision   = "allow"

  include {
    azure {
      identity_provider_id = cloudflare_access_identity_provider.azuread.id

      id = [
        azuread_group.users.object_id
      ]
    }
  }
}

resource "cloudflare_access_policy" "service_token" {
  account_id = sensitive(data.sops_file.secrets.data["cloudflare_account_id"])
  name       = "Cloudflare Service Token"
  decision   = "non_identity"

  include {
    service_token = [var.cloudflare_health_service_token_name]
  }
}
