variable "virginia_cidr" {
  description = "CIDR de la VPC de Virginia"
  type        = string
  sensitive   = false
}

variable "subnets" {
  description = "Lista de subnets"
}


variable "tags" {
  description = "Tags de la practica"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}
//ips de salida, habilito todo
variable "sg_egress_cidr" {
  description = "CIDR for egress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "Parametros de la instancia"
  type        = map(string)
}

variable "enable_monitoring" {
  description = "Habilita el despliegue de un  servidor de monitoreo"
  type        = number
}

variable "ingress_ports_list" {
  description = "Lista de puertos para las reglas de ingreso"
  type        = list(number)
}

variable "access_key" {
  
}

variable "secret_key" {
  
}