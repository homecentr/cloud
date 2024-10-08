resource "pagerduty_service" "snipeit" {
  name                    = "Snipe IT"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.default.id
  alert_creation          = "create_alerts_and_incidents"
}

resource "pagerduty_service_integration" "snipeit" {
  name              = "E-mail Alerts"
  type              = "generic_email_inbound_integration"
  integration_email = "snipe-it@${sensitive(data.sops_file.secrets.data["pagerduty_email_domain"])}"

  service = pagerduty_service.snipeit.id
}

resource "pagerduty_service_integration" "snipeit_gatus" {
  name = "Gatus"
  type = "events_api_v2_inbound_integration"

  service = pagerduty_service.snipeit.id
}
