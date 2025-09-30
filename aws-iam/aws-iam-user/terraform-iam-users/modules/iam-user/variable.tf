variable "user_name" {
    description = "name of the IAM user"
    type        = string  
}

variable "console_login" {
    description = "whether to enable AWS management console login"
    type        =  bool
    default     =  false   
  
}
variable "password" {
    description = "initial console passed for  the IAM user"
    type        =string
    default     =null
     
  
}
variable "policy_arns" {
    description  =  "list of iam policy arns to attach"
    type= list(string) 
    default=[]              
}