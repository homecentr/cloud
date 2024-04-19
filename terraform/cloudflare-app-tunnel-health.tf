resource "cloudflare_access_policy" "service_token" {
  for_each = { for each in var.cloudflare_apps : each.display_name => each }

  application_id = cloudflare_access_application.apps["tunnel-health"].id
  account_id     = sensitive(data.sops_file.secrets.data["cloudflare_account_id"])
  name           = "Service Token${var.display_name_environment_suffix}"
  precedence     = "3"
  decision       = "allow"

  include {
    service_token = [ var.cloudflare_health_service_token_name ]
  }
}