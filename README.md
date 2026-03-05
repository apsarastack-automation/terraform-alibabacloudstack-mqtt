# Alibaba Cloud MQTT Terraform Module

This module creates an **MQTT instance, topics, and groups** on Alibaba Cloud Stack.

## Features

- Creates a new MQTT instance  
- Automatically creates one or more MQTT topics (defined via `topic_definitions`)
- Automatically creates one or more MQTT groups (defined via `group_definitions`)
- Supports using an existing MQTT instance

> ⚠️ **Note**: This module supports both creating a new MQTT instance and using an existing one (via `mqtt_instance_id`).

## Usage

### Basic Usage: Create MQTT Instance with Topics and Groups

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
  }
}
```

### Advanced Usage: Use Existing MQTT Instance

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
}
```

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.5.6 |

## Provider

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `mqtt_instance_id` | ID of an existing MQTT instance | `string` | `""` | No |
| `name` | Name of the MQTT instance | `string` | `""` | No |
| `remark` | Remark for the MQTT instance | `string` | `""` | No |
| `max_conn` | Maximum number of connections | `number` | `1000` | No |
| `max_sub` | Maximum number of subscriptions | `number` | `10000` | No |
| `max_up_tps` | Maximum upstream TPS | `number` | `500` | No |
| `max_down_tps` | Maximum downstream TPS | `number` | `1000` | No |
| `independent_naming` | Whether to use independent namespace | `bool` | `true` | No |
| `store_instance_id` | Storage instance ID (RocketMQ instance ID) | `string` | `""` | No |
| `topic_definitions` | Map of topic names to configurations | `map(object)` | `{}` | No |
| `group_definitions` | Map of group IDs to configurations | `map(object)` | `{}` | No |

> 💡 **Mutual Exclusion Rule**: Either `mqtt_instance_id` or `name` must be set. `store_instance_id` is required when creating a new instance.

## Output Values

| Name | Description |
|------|-------------|
| `mqtt_instance_id` | ID of the MQTT instance |
| `mqtt_instance_name` | Name of the MQTT instance |
| `mqtt_topic_names` | List of created topic names |
| `mqtt_group_ids` | List of created group IDs |

## Examples

For more usage scenarios, see the [`examples/`](./examples) directory:
- `create-mqtt-instance-with-topics` - Create MQTT instance with topics and groups using existing ONS
- `create-mqtt-instance-with-ons` - Create MQTT instance with existing ONS instance
- `create-topics-for-existing-mqtt-instance` - Create topics and groups for existing MQTT instance

## Notes

- This module can create a new MQTT instance or use an existing one.
- Group IDs must start with `GID_` or `GID-`.
- Topic names must be 3-64 characters and can contain letters, digits, hyphens (-), underscores (_), and forward slashes (/).
