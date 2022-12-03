variable "display_name_environment_suffix" { type = string }

variable "aad_credentials" {
  type      = string
  sensitive = true
  default   = null
}

variable "proxmox_urls" { type = list(string) }

locals {
  aad_credentials = var.aad_credentials != null ? (
    jsondecode(var.aad_credentials)
    ) : ({ # Locally az login should be used
      client_id     = null,
      client_secret = null,
      tenant_id     = null
  })
}
