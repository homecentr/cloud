resource "pagerduty_service" "haraka" {
  name                    = "SMTP Relay (Haraka)"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.default.id
  alert_creation          = "create_alerts_and_incidents"
}

resource "pagerduty_service_integration" "haraka" {
  name              = "Haraka ACME Alerts"
  type              = "generic_email_inbound_integration"
  integration_email = "smtp-relay-acme@${sensitive(data.sops_file.secrets.data["pagerduty_email_domain"])}"

  service = pagerduty_service.haraka.id
}
