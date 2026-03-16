module "mqtt_instance" {
  source             = "../../modules/mqtt_instance"
  name               = var.instance_name
  remark             = var.remark
  create_ons_instance = true
  ons_name           = var.ons_name
  max_conn           = var.max_conn
  max_sub            = var.max_sub
  max_up_tps         = var.max_up_tps
  max_down_tps       = var.max_down_tps
  independent_naming = var.independent_naming
  topic_definitions  = var.topic_definitions
  group_definitions  = var.group_definitions
}
