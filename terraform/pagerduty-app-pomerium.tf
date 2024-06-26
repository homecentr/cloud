resource "pagerduty_service" "pomerium" {
  name                    = "Pomerium"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.default.id
  alert_creation          = "create_alerts_and_incidents"
}

resource "pagerduty_service_integration" "pomerium" {
  name              = "Pomerium ACME Alerts"
  type              = "generic_email_inbound_integration"
  integration_email = "pomerium-acme@${sensitive(data.sops_file.secrets.data["pagerduty_email_domain"])}"

  service = pagerduty_service.pomerium.id
}
