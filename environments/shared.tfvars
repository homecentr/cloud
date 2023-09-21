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
    subdomain        = "k8s"
    display_name     = "Kubernetes dashboard"
    allow_non_admins = false
  },
  {
    subdomain        = "argocd"
    display_name     = "Argo CD"
    allow_non_admins = false
  },
  {
    subdomain        = "cyberchef"
    display_name     = "CyberChef"
    allow_non_admins = true
  },
  {
    subdomain        = "nvr"
    display_name     = "Frigate NVR"
    allow_non_admins = true
  }
]
