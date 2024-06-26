resource "azuread_group" "users" {
  display_name     = "Users"
  mail_enabled     = false
  security_enabled = true

  owners = [
    data.azuread_user.admin.object_id
  ]

  lifecycle {
    prevent_destroy = true # To make sure the object id remains valid
  }
}

resource "azuread_group_member" "users_administrators" {
  group_object_id  = azuread_group.users.object_id
  member_object_id = azuread_group.administrators.object_id
}
