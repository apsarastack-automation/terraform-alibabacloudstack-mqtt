# Create New ONS and MQTT Instance

This example creates a new ONS (RocketMQ) instance as the storage backend, along with a new MQTT instance and configures topics and groups.

> Note: This example will create a new ONS/RocketMQ instance and MQTT instance.

## Usage

1. Configure variables (via `terraform.tfvars` or CLI):
   ```hcl
   instance_name = "my-mqtt"
   ons_name      = "my-ons"
   max_conn      = 2000
   max_sub       = 20000
   topic_definitions = {
     test_topic = {
       remark     = "Test topic"
       order_type = "0"
     }
     order_topic = {
       remark     = "Ordered topic"
       order_type = "1"
     }
   }
   group_definitions = {
     "GID_test_group" = {
       remark = "Test group"
     }
   }
   ```
2. Run:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. Clean up:
   ```bash
   terraform destroy
   ```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.6 |

## Provider

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Module

| Name | Source | Version |
|------|--------|---------|
| mqtt_instance | ../../modules/mqtt_instance | n/a |

## Resources Managed

| Name | Type |
|------|------|
| ONS instance | alibabacloudstack_ons_instance |
| MQTT instance | alibabacloudstack_mqtt_instance |
| MQTT topics | alibabacloudstack_mqtt_topic |
| MQTT groups | alibabacloudstack_mqtt_group |

## Input Variables

| Name | Description | Type | Example | Required |
|------|-------------|------|--------|----------|
| instance_name | Name of the MQTT instance to create. | string | "tfmqtt1" | Yes |
| remark | Remark for the MQTT instance. | string | "Test instance" | No |
| ons_name | Name of the ONS instance to create. Defaults to `{instance_name}MQ`. | string | "my-ons" | No |
| ons_remark | Remark for the ONS instance. | string | "ONS instance for MQTT" | No |
| ons_tps_receive_max | Maximum TPS for receiving messages in ONS instance. | number | 500 | No |
| ons_tps_send_max | Maximum TPS for sending messages in ONS instance. | number | 500 | No |
| ons_topic_capacity | Topic capacity of the ONS instance. | number | 50 | No |
| ons_cluster | Cluster name for the ONS instance. | string | "cluster1" | No |
| ons_independent_naming | Whether to use independent naming for the ONS instance. | string | "true" | No |
| max_conn | Maximum number of connections. | number | 1000 | No |
| max_sub | Maximum number of subscriptions. | number | 10000 | No |
| max_up_tps | Maximum upstream TPS. | number | 500 | No |
| max_down_tps | Maximum downstream TPS. | number | 1000 | No |
| independent_naming | Whether to use independent namespace. | bool | true | No |
| topic_definitions | Map of topic names to configurations. | map(map(string)) | See below | No |
| group_definitions | Map of group IDs to configurations. | map(map(string)) | See below | No |

Example `topic_definitions`:
```hcl
{
  topic1 = {
    remark     = "Normal topic"
    order_type = "0"
  }
  topic2 = {
    remark     = "Ordered topic"
    order_type = "1"
  }
}
```

Example `group_definitions`:
```hcl
{
  "GID_consumer1" = {
    remark = "Consumer group 1"
  }
  "GID_consumer2" = {
    remark = "Consumer group 2"
  }
}
```

## Output Variables

| Name | Description |
|------|-------------|
| mqtt_instance_id | ID of the created MQTT instance. |
| mqtt_instance_name | Name of the created MQTT instance. |
| mqtt_topic_names | List of created topic names. |
| mqtt_group_ids | List of created group IDs. |

## Notes

- This example will create a new ONS instance. Please ensure you have sufficient resource quotas.
- Group IDs must start with `GID_` or `GID-`.
- Topic names must be 3-64 characters and can contain letters, digits, hyphens (-), underscores (_), and forward slashes (/).
