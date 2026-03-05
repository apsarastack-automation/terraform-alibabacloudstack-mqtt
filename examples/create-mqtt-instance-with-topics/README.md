# MQTT Instance with Topics and Groups

This example creates a new MQTT instance with topics and groups.

> Note: This example requires a RocketMQ instance (ONS) to be created first, as MQTT uses ONS as its storage backend.

## Usage

1. Ensure you have an existing RocketMQ instance (e.g., `ons-xxxxxxxx`).
2. Configure variables (via `terraform.tfvars` or CLI):
   ```hcl
   instance_name     = "my-mqtt"
   store_instance_id = "ons-xxxxxxxx"
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
   ```
3. Run:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. Clean up:
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
| MQTT instance | alibabacloudstack_mqtt_instance |
| MQTT topics | alibabacloudstack_mqtt_topic |
| MQTT groups | alibabacloudstack_mqtt_group |

> Note: Not managed here: RocketMQ instance (assumed pre-existing).

## Input Variables

| Name | Description | Type | Example | Required |
|------|-------------|------|--------|----------|
| instance_name | Name of the new MQTT instance to create. | string | "tfmqtt1" | Yes |
| store_instance_id | ID of an existing RocketMQ instance to use as storage. | string | "ons-xxxxxxxx" | Yes |
| remark | Remark for the MQTT instance. | string | "Test instance" | No |
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

- The RocketMQ instance (`store_instance_id`) must already exist in your account.
- Group IDs must start with `GID_` or `GID-`.
- Topic names must be 3-64 characters and can contain letters, digits, hyphens (-), underscores (_), and forward slashes (/).
