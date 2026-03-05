module "mqtt_instance" {
  source            = "../../modules/mqtt_instance"
  mqtt_instance_id  = var.mqtt_instance_id
  topic_definitions = var.topic_definitions
  group_definitions = var.group_definitions
}
