variable "aws_configs" {
  type = object({
    region = string
    tags   = map(string)
  })
}

variable "ec2_configs" {
  type = object({
    name                        = string
    ami                         = string
    key_name                    = string
    instance_type               = string
    associate_public_ip_address = bool
  })
}