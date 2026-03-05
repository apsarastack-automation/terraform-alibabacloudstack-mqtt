variable "instance_name" {
  description = "The name of the MQTT instance to create."
  type        = string
}

variable "remark" {
  description = "The remark for the MQTT instance."
  type        = string
  default     = ""
}

variable "store_instance_id" {
  description = "The storage instance ID (RocketMQ instance ID)."
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
