run "setup_ons_instance" {
  command = apply
  module {
    source = "./setup_instance/simple_ons"
  }
  variables {
    name = "tfons2"
  }
}

run "setup_mqtt_instance" {
  command = apply
  module {
    source = "./setup_instance/simple_mqtt"
  }
  variables {
    name            = "tfmqtt2"
    ons_instance_id = run.setup_ons_instance.ons_instance_id
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/create-topics-for-existing-mqtt-instance"
  }
  variables {
    mqtt_instance_id = run.setup_mqtt_instance.mqtt_instance_id
    topic_definitions = {
      topic1 = {
        remark     = "Topic 1"
        order_type = "0"
      }
      topic2 = {
        remark     = "Topic 2"
        order_type = "1"
      }
    }
    group_definitions = {
      "GID_consumer1" = {
        remark = "Consumer group 1"
      }
      "GID_consumer2" = {
        remark = "Consumer group 2"
      }
    }
  }
  assert {
    condition     = output.mqtt_instance_id != ""
    error_message = "MQTT instance ID should not be empty."
  }
  assert {
    condition     = length(output.mqtt_topic_names) == 2
    error_message = "Exactly two topics should be created."
  }
  assert {
    condition     = length(output.mqtt_group_ids) == 2
    error_message = "Exactly two groups should be created."
  }
}
