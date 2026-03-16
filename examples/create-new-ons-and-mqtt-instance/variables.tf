variable "instance_name" {
  description = "The name of the MQTT instance to create."
  type        = string
}

variable "remark" {
  description = "The remark for the MQTT instance."
  type        = string
  default     = ""
}

variable "ons_name" {
  description = "The storage instance ID (RocketMQ/ONS instance ID)."
  type        = string
}

variable "max_conn" {
  description = "The maximum number of connections."
  type        = number
  default     = 1000
}

variable "max_sub" {
  description = "The maximum number of subscriptions."
  type        = number
  default     = 10000
}

variable "max_up_tps" {
  description = "The maximum upstream TPS."
  type        = number
  default     = 500
}

variable "max_down_tps" {
  description = "The maximum downstream TPS."
  type        = number
  default     = 1000
}

variable "independent_naming" {
  description = "Whether to use independent namespace."
  type        = bool
  default     = true
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
