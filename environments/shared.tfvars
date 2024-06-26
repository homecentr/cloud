cloudflare_apps = [
  {
    subdomain           = "login"
    display_name        = "Login"
    allow_non_admins    = true,
    allow_service_token = false
  },
  # {
  #   subdomain        = "pve"
  #   display_name     = "Proxmox VE"
  #   allow_non_admins = false
  # },
  {
    subdomain           = "pihole1"
    display_name        = "Pi-hole 1"
    allow_non_admins    = false,
    allow_service_token = true
  },
  {
    subdomain           = "pihole2"
    display_name        = "Pi-hole 2"
    allow_non_admins    = false,
    allow_service_token = true
  },
  {
    subdomain           = "status"
    display_name        = "Gatus"
    allow_non_admins    = true,
    allow_service_token = true
  },
  {
    subdomain           = "grafana"
    display_name        = "Grafana"
    allow_non_admins    = true,
    allow_service_token = true
  },
  {
    subdomain           = "prometheus"
    display_name        = "Prometheus"
    allow_non_admins    = true,
    allow_service_token = true
  },
  {
    subdomain           = "unifi"
    display_name        = "Unifi Controller"
    allow_non_admins    = false,
    allow_service_token = true
  },
  {
    subdomain           = "docs"
    display_name        = "Docs"
    allow_non_admins    = true,
    allow_service_token = true
  },
  {
    subdomain           = "tunnel-health"
    display_name        = "Cloudflare Tunnel Healthcheck"
    allow_non_admins    = true,
    allow_service_token = true
  },
]
