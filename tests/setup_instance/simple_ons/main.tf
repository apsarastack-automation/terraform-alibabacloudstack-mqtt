resource "alibabacloudstack_ons_instance" "existing" {
  tps_receive_max    = 500
  tps_send_max       = 500
  topic_capacity     = 50
  cluster            = "cluster1"
  independent_naming = "true"
  name               = "${var.name}-ons"
  remark             = "ONS-instance-for-MQTT-testing"
}
