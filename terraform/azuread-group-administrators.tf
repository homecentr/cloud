resource "azuread_group" "administrators" {
  display_name     = "Administrators"
  mail_enabled     = false
  security_enabled = true

  owners = [
    data.azuread_user.admin.object_id
  ]

  lifecycle {
    prevent_destroy = true # To make sure the object id remains valid
  }
}

resource "azuread_group_member" "administrators_admin" {
  group_object_id  = azuread_group.administrators.object_id
  member_object_id = data.azuread_user.admin.object_id
}
