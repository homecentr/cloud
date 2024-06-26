cloudflare_apps = [
  {
    subdomain        = "homepage"
    display_name     = "Homepage"
    allow_non_admins = true
  },
  {
    subdomain        = "login"
    display_name     = "Login"
    allow_non_admins = true
  },
  {
    subdomain        = "pve"
    display_name     = "Proxmox VE"
    allow_non_admins = false
  },
  {
    subdomain        = "status"
    display_name     = "Gatus"
    allow_non_admins = true
  },
  {
    subdomain        = "pihole1"
    display_name     = "Pi-hole 1"
    allow_non_admins = false
  },
  {
    subdomain        = "pihole2"
    display_name     = "Pi-hole 2"
    allow_non_admins = false
  },
  {
    subdomain        = "tunnel-health"
    display_name     = "Cloudflare Tunnel Healthcheck"
    allow_non_admins = true
  },
]
