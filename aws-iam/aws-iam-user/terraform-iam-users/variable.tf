variable "region" {
   description = "AWS REGION"  
   type = string
   default= "ap-south-1"
}
variable "user" {
    description = "MAP to  iam  users"
    type = map(object({
      console_login ="bool"
      password =string
      policy_arns=list(string) 
    }))
  
}