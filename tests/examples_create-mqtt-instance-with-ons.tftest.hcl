run "validate" {
  command = apply
  module {
    source = "../examples/create-mqtt-instance-with-ons"
  }
  variables {
    instance_name = "tfmqtt"
    ons_name      = "tfons"
    topic_definitions = {
      test_topic = {
        remark     = "Test topic"
        order_type = "0"
      }
    }
    group_definitions = {
      "GID_test_group" = {
        remark = "Test group"
      }
    }
  }
  assert {
    condition     = output.mqtt_instance_id != ""
    error_message = "MQTT instance ID should not be empty."
  }
  assert {
    condition     = output.mqtt_instance_name == "tfmqtt"
    error_message = "MQTT instance name should match the input."
  }
  assert {
    condition     = length(output.mqtt_topic_names) == 1
    error_message = "Exactly one topic should be created."
  }
  assert {
    condition     = length(output.mqtt_group_ids) == 1
    error_message = "Exactly one group should be created."
  }
}
