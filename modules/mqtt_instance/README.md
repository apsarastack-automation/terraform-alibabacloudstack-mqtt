# Alibaba Cloud MQTT Terraform Module

This module manages Alibaba Cloud MQTT instances, topics, and groups on Alibaba Cloud Stack.

## Supported Resources

* [alibabacloudstack_mqtt_instance](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/mqtt_instance)
* [alibabacloudstack_mqtt_topic](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/mqtt_topic)
* [alibabacloudstack_mqtt_group](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/mqtt_group)

## Usage Examples

### Scenario 1: Create a new MQTT instance with topics and groups

```hcl
module "mqtt" {
  source = "./terraform-alibabacloudstack-mqtt"

  name              = "my-mqtt-instance"
  remark            = "Terraform managed MQTT instance"
  store_instance_id = "ons-xxxxxxxx"
  
  topic_definitions = {
    topic1 = {
      remark     = "Normal topic"
      order_type = "0"
    }
    topic2 = {
      remark     = "Ordered topic"
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
```

### Scenario 2: Create topics and groups for an existing MQTT instance

```hcl
module "mqtt" {
  source = "./terraform-alibabacloudstack-mqtt"

  mqtt_instance_id = "existing-mqtt-id"
  
  topic_definitions = {
    new_topic = {
      remark     = "New topic"
      order_type = "0"
    }
  }

  group_definitions = {
    "GID_new_group" = {
      remark = "New group"
    }
  }
}
```

### Scenario 3: Create MQTT instance with auto-created ONS instance

```hcl
module "mqtt" {
  source = "./terraform-alibabacloudstack-mqtt"

  name                = "my-mqtt-instance"
  remark              = "Terraform managed MQTT instance"
  create_ons_instance = true
  ons_name            = "my-ons-instance"
  
  topic_definitions = {
    topic1 = {
      remark     = "Normal topic"
      order_type = "0"
    }
  }

  group_definitions = {
    "GID_consumer1" = {
      remark = "Consumer group 1"
    }
  }
}
```

> ⚠️ **Key Constraints**:
> - `mqtt_instance_id` and `name` are **mutually exclusive**: exactly one must be set.
> - `store_instance_id` is required when creating a new MQTT instance.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.6 |

## Providers

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| **mqtt_instance_id** | **ID of an existing MQTT instance. If set, no new instance will be created, and `name` is ignored.** | `string` | `""` | No |
| **name** | **Name for a new MQTT instance. Used only when `mqtt_instance_id` is not set.** | `string` | `""` | No |
| remark | Remark for the MQTT instance | `string` | `""` | No |
| max_conn | Maximum number of connections | `number` | `1000` | No |
| max_sub | Maximum number of subscriptions | `number` | `10000` | No |
| max_up_tps | Maximum upstream TPS | `number` | `500` | No |
| max_down_tps | Maximum downstream TPS | `number` | `1000` | No |
| independent_naming | Whether to use independent namespace | `bool` | `true` | No |
| store_instance_id | Storage instance ID (RocketMQ instance ID). Required when creating a new instance. | `string` | `""` | No |
| topic_definitions | Map of topic names to their configurations | `map(object)` | `{}` | No |
| group_definitions | Map of group IDs to their configurations | `map(object)` | `{}` | No |

> 💡 **Mutual Exclusion Rules**:
> - `mqtt_instance_id` and `name`: choose exactly one.
> - `store_instance_id` is required when `mqtt_instance_id` is not set.

## Output Values

| Name | Description |
|------|-------------|
| mqtt_instance_id | ID of the MQTT instance (either newly created or pre-existing) |
| mqtt_instance_name | Name of the MQTT instance |
| mqtt_topic_names | List of MQTT topic names that were created |
| mqtt_group_ids | List of MQTT group IDs that were created |

## Notes

* When creating a new MQTT instance, `store_instance_id` (RocketMQ instance ID) is required.
* Group IDs must start with `GID_` or `GID-`.
* Topic names must be 3-64 characters in length and can contain letters, digits, hyphens (-), underscores (_), and forward slashes (/).

## Reporting Issues

If you encounter any issues while using this module, please open an issue in the [provider repository](https://github.com/aliyun/terraform-provider-alibabacloudstack/issues/new).

> **Note**: Please do **not** open issues in this module's repository.

## Authors

Created and maintained by the Alibaba Cloud Terraform Team.

## License

MIT License. See LICENSE for details.

## References

* [Terraform Provider for Alibaba Cloud Stack (GitHub)](https://github.com/aliyun/terraform-provider-alibabacloudstack)
* [Terraform Provider Registry](https://registry.terraform.io/providers/aliyun/alibabacloudstack)
* [Provider Documentation](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs)
