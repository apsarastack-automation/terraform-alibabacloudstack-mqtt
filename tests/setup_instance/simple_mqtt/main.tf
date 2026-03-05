resource "alibabacloudstack_mqtt_instance" "existing" {
  instance_name      = var.name
  remark             = var.name
  max_conn           = 1000
  max_sub            = 10000
  max_up_tps         = 500
  max_down_tps       = 1000
  store_instance_id  = var.ons_instance_id
}