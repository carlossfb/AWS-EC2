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
  key_name   = var.ec2_configs.key_name
  public_key = file("./${var.ec2_configs.key_name}.pub")
}

resource "aws_instance" "vm" {
  ami                         = var.ec2_configs.ami
  instance_type               = var.ec2_configs.instance_type
  key_name                    = aws_key_pair.key.key_name
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true

  tags = {
    Name = var.ec2_configs.name
  }
}