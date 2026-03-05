output "mqtt_instance_id" {
  description = "The ID of the created ONS instance."
  value       = alibabacloudstack_mqtt_instance.existing.id
}
