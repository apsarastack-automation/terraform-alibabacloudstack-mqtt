# Create Topics and Groups for an Existing MQTT Instance

This Terraform example **creates one or more topics and groups in an existing Alibaba Cloud MQTT instance**.  
It invokes the `mqtt_instance` module to manage topics and groups only-**no new MQTT instance will be created**.

## Usage

1. Ensure an MQTT instance already exists (e.g., `mqtt-xxxxxxxx`).
2. Configure variables (via `terraform.tfvars` or command line):
   ```hcl
   mqtt_instance_id = "mqtt-xxxxxxxx"
   topic_definitions = {
     test_topic = {
       remark     = "Test topic"
       order_type = "0"
     }
     order_topic = {
       remark     = "Order topic"
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
   ```
3. Run the following commands:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. Clean up resources (topics and groups only-MQTT instance remains unaffected):
   ```bash
   terraform destroy
   ```

> ⚠️ **Note**: This operation **does not delete or modify the MQTT instance itself**-it only manages topics and groups within it.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.5.6 |

## Provider

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Module Dependency

| Module Name | Source Path |
|-------------|-------------|
| `mqtt_instance` | `../../modules/mqtt_instance` |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `mqtt_instance_id` | **ID of an existing MQTT instance** | `string` | - | Yes |
| `topic_definitions` | Map of topic names to configurations (`{ topic_name = { remark = "", order_type = "0" } }`) | `map(map(string))` | `{}` | No |
| `group_definitions` | Map of group IDs to configurations (`{ "GID_xxx" = { remark = "" } }`) | `map(map(string))` | `{}` | No |

> 💡 **Supported order_type values**: `"0"` (normal), `"1"` (ordered)

## Output Values

| Name | Description |
|------|-------------|
| `mqtt_instance_id` | ID of the MQTT instance being managed |
| `mqtt_instance_name` | Name of the MQTT instance being managed |
| `mqtt_topic_names` | List of topic names that were actually created |
| `mqtt_group_ids` | List of group IDs that were actually created |

## Notes

- This example **assumes the MQTT instance already exists**. If the specified `mqtt_instance_id` does not exist, Terraform will fail.
- Running `terraform destroy` **only deletes topics and groups created by this configuration**-it does not affect the MQTT instance or other resources.
- Group IDs must start with `GID_` or `GID-`.
- Topic names must be 3-64 characters and can contain letters, digits, hyphens (-), underscores (_), and forward slashes (/).

## References

- [MQTT Topic Management Documentation](https://help.aliyun.com/document_detail/29532.html)
- [alibabacloudstack_mqtt_topic Resource](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/mqtt_topic)
- [alibabacloudstack_mqtt_group Resource](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/mqtt_group)
