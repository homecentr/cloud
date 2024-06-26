resource "cloudflare_record" "ssh" {
  for_each = { for each in var.cloudflare_ssh_hosts : each.hostname => each }

  zone_id = sensitive(data.sops_file.secrets.data["cloudflare_zone_id"])
  name    = "${each.key}.${var.cloudflare_apps_root_domain}"
  type    = "CNAME"
  value   = cloudflare_tunnel.default.cname
  ttl     = 1
  proxied = true
}

resource "cloudflare_access_application" "ssh" {
  for_each = { for each in var.cloudflare_ssh_hosts : each.hostname => each }

  account_id                = sensitive(data.sops_file.secrets.data["cloudflare_account_id"])
  name                      = "SSH / ${each.key}.${var.cloudflare_apps_root_domain}"
  domain                    = "${each.key}.${var.cloudflare_apps_root_domain}"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = true
  allowed_idps              = [cloudflare_access_identity_provider.azuread.id]

  policies = [
    cloudflare_access_policy.administrators.id
  ]
}