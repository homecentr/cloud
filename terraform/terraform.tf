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
      version = "2.52.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.35.0"
    }

    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "3.0.1"
    }

    sops = {
      source  = "carlpett/sops"
      version = "~> 0.5"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }
  }
}

provider "azuread" {
  client_id     = local.aad_credentials.client_id
  client_secret = local.aad_credentials.client_secret
  tenant_id     = local.aad_credentials.tenant_id
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "pagerduty" {
  token          = var.pagerduty_api_token
  service_region = "eu"
}
