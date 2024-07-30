##################################################################
#_____ SECURITY GROUP ___________________________________________#
##################################################################
resource "aws_security_group" "sg" {
  name   = "sg"
  vpc_id = data.aws_vpc.default.id

  ingress = []
  egress  = []
}

##################################################################
#_____ VIRTUAL MACHINE __________________________________________#
##################################################################
resource "aws_key_pair" "key" {
  for_each = { for i in var.ec2 : i.name => i if i.key_name != null }

  key_name   = each.value.key_name
  public_key = file("./${each.value.key_name}.pub")
}

resource "aws_instance" "this" {
  for_each = { for i in var.ec2 : i.name => i if i.user_data == null }

  ami                         = each.value.ami == null ? data.aws_ami.windows_server.id : each.value.ami
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  vpc_security_group_ids      = each.value.security_group_ids == null ? [aws_security_group.sg.id] : each.value.security_group_ids
  associate_public_ip_address = each.value.associate_public_ip_address

  tags = {
    Name = each.value.name
  }
}

resource "aws_instance" "user_data" {
  for_each = { for i in var.ec2 : i.name => i if i.user_data != null }

  ami                         = each.value.ami == null ? data.aws_ami.windows_server.id : each.value.ami
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  user_data                   = each.value.user_data
  vpc_security_group_ids      = each.value.security_group_ids == null ? [aws_security_group.sg.id] : each.value.security_group_ids
  associate_public_ip_address = each.value.associate_public_ip_address

  tags = {
    Name = each.value.name
  }
}