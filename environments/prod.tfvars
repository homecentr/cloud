environment_name                = "prod"

pomerium_redirect_urls = [
  "https://login.homecentr.one/oauth2/callback"
]

proxmox_redirect_urls = [
  "https://pve.homecentr.one/",
  "https://pve1.homecentr.one/",
  "https://pve2.homecentr.one/",
  "https://pve3.homecentr.one/",
]

proxmox_backup_server_redirect_urls = [
  "https://pbs.homecentr.one/"
]

grafana_redirect_urls = [
  "https://grafana.homecentr.one/",
  "https://grafana.homecentr.one/login/generic_oauth"
]

wikijs_redirect_urls = [
  "https://docs.homecentr.one/login/16560089-1af1-490f-ab52-8c0fded45221/callback",

  "https://docs.homecentr.one/login/1b25df86-74d1-48ae-bbff-4bedae784776/callback"
]

cloudflare_ssh_hosts = [
  { hostname = "pve1" },
  { hostname = "pve2" },
  { hostname = "pve3" }
]

cloudflare_apps_subdomain_suffix = ""
cloudflare_apps_root_domain      = "homecentr.one"
cloudflare_health_service_token_name = "6db2c43c-9434-48a2-8036-dcebbcc8dbfe"