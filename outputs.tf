output "mqtt_instance_id" {
  description = "The ID of the MQTT instance."
  value       = module.default.mqtt_instance_id
}

output "mqtt_instance_name" {
  description = "The name of the MQTT instance."
  value       = module.default.mqtt_instance_name
}

output "mqtt_topic_names" {
  description = "The names of the MQTT topics that were created."
  value       = module.default.mqtt_topic_names
}

output "mqtt_group_ids" {
  description = "The IDs of the MQTT groups that were created."
  value       = module.default.mqtt_group_ids
}
