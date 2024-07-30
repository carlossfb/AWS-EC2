##################################################################
#_____ NETWORK __________________________________________________#
##################################################################
data "aws_vpc" "default" {
  default = true
}


##################################################################
#_____ WINDOWS SERVER IMAGE _____________________________________#
##################################################################
data "aws_ami" "windows_server" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
