resource "aws_iam_user" "new_user" {
    name=var.user_name
  
}
resource "aws_iam_user_login_profile" "user_login_profile" {
    count = var.console_login ? 1 : 0
    user =var.user_name
    password_reset_required = true
}

resource "aws_iam_access_key" "user_access_key" {
    user=aws_iam_user.new_user.name
}
resource "aws_iam_user_policy_attachment" "attach_policy" {
    for_each=toset(var.policy_arns)

    user= aws_iam_user.new_user.name
    policy_arn = each.value

  
}
