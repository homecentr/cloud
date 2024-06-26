resource "cloudflare_record" "apps" {
  for_each = { for each in var.cloudflare_apps : each.display_name => each }

  zone_id = data.sops_file.secrets.data["cloudflare_zone_id"]
  name    = "${each.value.subdomain}${var.cloudflare_apps_subdomain_suffix}.${var.cloudflare_apps_root_domain}"
  type    = "CNAME"
  value   = cloudflare_tunnel.default.cname
  ttl     = 1
  proxied = true
}

resource "cloudflare_access_application" "apps" {
  for_each = { for each in var.cloudflare_apps : each.display_name => each }

  account_id                = sensitive(data.sops_file.secrets.data["cloudflare_account_id"])
  name                      = each.value.display_name
  domain                    = "${each.value.subdomain}${var.cloudflare_apps_subdomain_suffix}.${var.cloudflare_apps_root_domain}"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = true
  allowed_idps              = [cloudflare_access_identity_provider.azuread.id]

  policies = flatten([
    cloudflare_access_policy.administrators.id,
    each.value.allow_non_admins ? [cloudflare_access_policy.users.id] : [],
    each.value.allow_service_token ? [cloudflare_access_policy.service_token.id] : [],
  ])
}
