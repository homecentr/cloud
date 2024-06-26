resource "azuread_application" "gatus" {
  display_name     = "Gatus"
  sign_in_audience = "AzureADMyOrg"
  logo_image       = filebase64("../icons/gatus.png")

  api {
    requested_access_token_version = "2"
  }

  feature_tags {
    enterprise = false
    gallery    = false
  }
}
