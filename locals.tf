locals {
  sufix = "${var.tags.project}-${var.tags.env}-${var.tags.region}" //recurso-projecto-entorno-region
}

resource "random_string" "sufix_s3" {
  length  = 5
  special = false
  upper   = false
}

locals {
  s3_sufix = "${var.tags.project}-${random_string.sufix_s3.id}"
}