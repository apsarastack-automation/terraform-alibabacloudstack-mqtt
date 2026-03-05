variable "mqtt_instance_id" {
  description = "The ID of an existing MQTT instance"
  type        = string
}

variable "topic_definitions" {
  description = "Map of topic names to their configurations"
  type        = map(map(string))
  default     = {}
}

variable "group_definitions" {
  description = "Map of group IDs to their configurations"
  type        = map(map(string))
  default     = {}
}
