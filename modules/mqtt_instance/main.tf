# --- Data Sources ---

data "alibabacloudstack_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alibabacloudstack_mqtt_instances" "default" {
  ids = [coalesce(var.mqtt_instance_id, "fake_id")]
}

data "alibabacloudstack_ons_instances" "default" {
  ids = [coalesce(var.store_instance_id, "fake_id")]
}

# --- Control flags ---

locals {
  # Determine if we need to create a new instance
  create_instance     = var.mqtt_instance_id == ""
  create_ons_instance = var.store_instance_id == "" && var.mqtt_instance_id == ""
}

# --- Ons Instance Resource ---
resource "alibabacloudstack_ons_instance" "default" {
  count              = local.create_ons_instance ? 1 : 0
  tps_receive_max    = var.ons_tps_receive_max
  tps_send_max       = var.ons_tps_send_max
  topic_capacity     = var.ons_topic_capacity
  cluster            = var.ons_cluster
  independent_naming = var.ons_independent_naming
  name               = var.ons_name != "" ? var.ons_name : "${var.name}MQ"
  remark             = var.ons_remark
}

locals {
  ons_instance_id = local.create_ons_instance ? alibabacloudstack_ons_instance.default.0.id : (length(data.alibabacloudstack_ons_instances.default.ids) > 0 ? data.alibabacloudstack_ons_instances.default.ids.0 : "")
}

# --- MQTT Instance Resource ---

resource "alibabacloudstack_mqtt_instance" "default" {
  count              = local.create_instance ? 1 : 0
  instance_name      = var.name
  remark             = var.remark
  max_conn           = var.max_conn
  max_sub            = var.max_sub
  max_up_tps         = var.max_up_tps
  max_down_tps       = var.max_down_tps
  cluster_name       = var.cluster_name
  independent_naming = var.independent_naming
  store_instance_id  = local.ons_instance_id

  depends_on = [alibabacloudstack_ons_instance.default]
}

# --- MQTT Instance derived locals ---

locals {
  # The actual MQTT instance ID (either newly created or pre-existing)
  mqtt_instance_id = local.create_instance ? alibabacloudstack_mqtt_instance.default.0.id : (length(data.alibabacloudstack_mqtt_instances.default.ids) > 0 ? data.alibabacloudstack_mqtt_instances.default.ids.0 : "")

  # The actual MQTT instance name
  mqtt_instance_name = local.create_instance ? alibabacloudstack_mqtt_instance.default.0.instance_name : (length(data.alibabacloudstack_mqtt_instances.default.instances) > 0 ? data.alibabacloudstack_mqtt_instances.default.instances.0.instance_name : "")

  store_instance_id = local.create_instance ? alibabacloudstack_mqtt_instance.default.0.store_instance_id : (length(data.alibabacloudstack_mqtt_instances.default.instances) > 0 ? data.alibabacloudstack_mqtt_instances.default.instances.0.store_instance_id : "")

}

# --- MQTT Topic Resources ---

resource "alibabacloudstack_mqtt_topic" "default" {
  for_each          = var.topic_definitions
  topic             = each.key
  remark            = each.value.remark
  order_type        = each.value.order_type
  store_instance_id = local.store_instance_id
  depends_on        = [alibabacloudstack_mqtt_instance.default]
}

# --- MQTT Group Resources ---

resource "alibabacloudstack_mqtt_group" "default" {
  for_each = var.group_definitions

  group_id    = each.key
  instance_id = local.mqtt_instance_id

  depends_on = [alibabacloudstack_mqtt_instance.default]
}
