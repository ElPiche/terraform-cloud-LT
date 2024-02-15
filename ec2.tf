variable "instancias" {
  description = "Nombre de las instancias"
  type        = set(string)
  //type = list(string) puedo usarla si en la instancia la casteo a set
  //default = ["apache", "mysql", "jumpserver"]
  default = ["apache"]

}


resource "aws_instance" "public_instance" {
  //count                  = length(var.instancias)
  //en caso de que se rompa hay una forma de castear -> for_each = toset(var.instancias)
  for_each               = var.instancias
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.keyTest.key_name
  user_data              = file("userData.sh")
  vpc_security_group_ids = [aws_security_group.public_instance_sg.id]

  tags = {
    Name = "${each.value}-${local.sufix}"
  }
}

resource "aws_instance" "monitoring_instance" {
  count = var.enable_monitoring == 1 ? 1 : 0

  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.keyTest.key_name
  user_data              = file("userData.sh")
  vpc_security_group_ids = [aws_security_group.public_instance_sg.id]

  tags = {
    Name = "Monitoreo-${local.sufix}"
  }
}
