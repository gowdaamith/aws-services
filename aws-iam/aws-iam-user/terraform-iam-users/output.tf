output "user_access_keys"{
    description = "programmatic access keys for IAM users"
    value = {
        for k ,v in module.module.iam_user : k => v.access_key
    }
    sensitive = true
}
output "console_login_urls" {
    description = "aws console login url for IAM users"
    value = {
        for k ,v in module.iam_users : k => v.console_login_url
    }
  
}