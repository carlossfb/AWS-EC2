variable "aws_configs" {
  type = object({
    region = string
    tags   = map(string)
  })
}

variable "ec2" {
  type = list(object({
    name                        = string
    ami                         = optional(string, null)
    instance_type               = optional(string, "t2.micro")
    key_name                    = optional(string, null)
    user_data                   = optional(string, null)
    security_group_ids          = optional(list(string), null)
    associate_public_ip_address = optional(bool, false)
  }))
}