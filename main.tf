module "default" {
  source = "./modules/mqtt_instance"

  mqtt_instance_id   = var.mqtt_instance_id
  name               = var.name
  remark             = var.remark
  max_conn           = var.max_conn
  max_sub            = var.max_sub
  max_up_tps         = var.max_up_tps
  max_down_tps       = var.max_down_tps
  independent_naming = var.independent_naming
  store_instance_id  = var.store_instance_id

  # ONS Instance variables
  create_ons_instance    = var.create_ons_instance
  ons_name               = var.ons_name
  ons_remark             = var.ons_remark
  ons_tps_receive_max    = var.ons_tps_receive_max
  ons_tps_send_max       = var.ons_tps_send_max
  ons_topic_capacity     = var.ons_topic_capacity
  ons_cluster            = var.ons_cluster
  ons_independent_naming = var.ons_independent_naming

  topic_definitions = var.topic_definitions
  group_definitions = var.group_definitions
}
