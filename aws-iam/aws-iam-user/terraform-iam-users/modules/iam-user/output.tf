output "access_key"{
    description = "Access key details (id + secret)"
    value = {
        id=aws_iam_access_key.access_key.id
        secret=aws_iam_access_key.access_key.secret
    }
    sensitive = true
}
output "console_login_url" {
    description = "Console login url (if enable)"
    value="https://console.aws.amazon.com/"  
}