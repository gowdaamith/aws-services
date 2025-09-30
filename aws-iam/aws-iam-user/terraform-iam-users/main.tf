module "iam_user" {
    source = "./modules/iam-user"
    for_each=var.user

    user_name = each.key
    console_login = each.value.console_login
    password = each.value.password
    policy_arns = each.value.polcy_arns
  
}