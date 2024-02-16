resource "aws_vpc" "vpc_terraform_virginia" {
  cidr_block = var.virginia_cidr

  tags = {
    Name = "VPC_TERRAFORM_VIRGINIA-${local.sufix}"
  }
}



resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc_terraform_virginia.id
  cidr_block = var.subnets[0]
  //este parametro le otorga la capacidad a una subnet para que sea publica y pueda otorgar ip's publicas a los elementos.
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet Publica-${local.sufix}"
  }
}

//subnet privada
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_terraform_virginia.id
  cidr_block = var.subnets[1]

  tags = {
    Name = "Subnet Privada-${local.sufix}"
  }
  depends_on = [
    aws_subnet.public_subnet
  ]
}

resource "aws_internet_gateway" "gw_vpc_virginia" {
  vpc_id = aws_vpc.vpc_terraform_virginia.id

  tags = {
    Name = "GW_VPCVirginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_terraform_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_vpc_virginia.id
  }

  tags = {
    Name = "Tabla de enrutamiento personalizada-${local.sufix}"
  }
}

//asociar tabla de enrutamiento a una subnet
resource "aws_route_table_association" "crtAssociation_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}



//security group (firewall), para controlar ingreso y egreso de trafico.
resource "aws_security_group" "public_instance_sg" {
  name        = "Public instance security group"
  description = "Allow SSH inbound traffic and ALL egress traffic"
  vpc_id      = aws_vpc.vpc_terraform_virginia.id


  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  tags = {
    Name = "Public instance security group-${local.sufix}"
  }
}






resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.public_instance_sg.id
  cidr_ipv4         = var.sg_egress_cidr
  ip_protocol       = "-1" # semantically equivalent to all ports
}

//change to test

