module "mqtt_instance" {
  source            = "../../modules/mqtt_instance"
  name              = var.instance_name
  remark            = var.remark
  store_instance_id = var.store_instance_id
  topic_definitions = var.topic_definitions
  group_definitions = var.group_definitions
}
