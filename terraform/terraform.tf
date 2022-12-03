terraform {
  backend "remote" {
    organization = "homecentr"

    workspaces {
      prefix = "cloud-"
    }
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.31.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.29.0"
    }
  }
}

provider "azuread" {
  client_id     = local.aad_credentials.client_id
  client_secret = local.aad_credentials.client_secret
  tenant_id     = local.aad_credentials.tenant_id
}
