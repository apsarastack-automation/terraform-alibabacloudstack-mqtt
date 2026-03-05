run "setup_ons_instance" {
  command = apply
  module {
    source = "./setup_instance/simple_ons"
  }
  variables {
    name = "tfons3"
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/create-mqtt-instance-with-topics"
  }
  variables {
    instance_name     = "tfmqtt-test"
    remark            = "Test MQTT instance with topics and groups"
    store_instance_id = run.setup_ons_instance.ons_instance_id
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
    condition     = output.mqtt_instance_name == "tfmqtt-test"
    error_message = "MQTT instance name should match the input."
  }

  assert {
    condition     = length(output.mqtt_topic_names) > 0
    error_message = "At least one MQTT topic should be created."
  }

  assert {
    condition     = length(output.mqtt_group_ids) > 0
    error_message = "At least one MQTT group should be created."
  }
}
