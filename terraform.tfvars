virginia_cidr = "10.10.0.0/16"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "env"         = "dev"
  "owner"       = "Lucas"
  "cloud"       = "AWS"
  "IAC"         = "Terraform"
  "IAC_Version" = "1.7.2"
  "project"     = "cerberus"
  "region"      = "Virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

sg_egress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-0277155c3f0ab2930"
  "instance_type" = "t2.micro"

}

enable_monitoring = 0

ingress_ports_list = [22, 80, 443]