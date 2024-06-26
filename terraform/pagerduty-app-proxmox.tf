resource "pagerduty_service" "proxmox" {
  name                    = "Proxmox VE"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.default.id
  alert_creation          = "create_alerts_and_incidents"
}

resource "pagerduty_service_integration" "proxmox" {
  name              = "Proxmox E-mail Alerts"
  type              = "generic_email_inbound_integration"
  integration_email = "proxmox@${sensitive(data.sops_file.secrets.data["pagerduty_email_domain"])}"

  service = pagerduty_service.proxmox.id
}
