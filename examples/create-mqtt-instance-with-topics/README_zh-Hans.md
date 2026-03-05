# 带 Topic 和 Group 的 MQTT 实例

本示例用于创建一个新的 MQTT 实例，并配置 Topic 和 Group。

> 注意：本示例需要先创建 RocketMQ 实例（ONS），因为 MQTT 使用 ONS 作为其存储后端。

## 使用方法

1. 确保您已有一个 RocketMQ 实例（例如 `ons-xxxxxxxx`）。
2. 通过 `terraform.tfvars` 或命令行配置变量：
   ```hcl
   instance_name     = "my-mqtt"
   store_instance_id = "ons-xxxxxxxx"
   topic_definitions = {
     test_topic = {
       remark     = "测试Topic"
       order_type = "0"
     }
   }
   group_definitions = {
     "GID_test_group" = {
       remark = "测试Group"
     }
   }
   ```
3. 执行以下命令：
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. 清理资源：
   ```bash
   terraform destroy
   ```

## 要求

| 名称 | 版本 |
|------|------|
| terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 模块

| 名称 | 来源 | 版本 |
|------|------|------|
| mqtt_instance | ../../modules/mqtt_instance | n/a |

## 管理的资源

| 名称 | 类型 |
|------|------|
| MQTT 实例 | alibabacloudstack_mqtt_instance |
| MQTT Topic | alibabacloudstack_mqtt_topic |
| MQTT Group | alibabacloudstack_mqtt_group |

> 注意：RocketMQ 实例**不在本配置中管理**（假定已存在）。

## 输入变量

| 名称 | 描述 | 类型 | 示例值 | 必需 |
|------|------|------|--------|------|
| instance_name | 要创建的新 MQTT 实例名称。 | string | "tfmqtt1" | 是 |
| store_instance_id | 用作存储后端的已有 RocketMQ 实例 ID。 | string | "ons-xxxxxxxx" | 是 |
| remark | MQTT 实例的备注。 | string | "测试实例" | 否 |
| topic_definitions | Topic 名称到配置的映射。 | map(map(string)) | 见下方示例 | 否 |
| group_definitions | Group ID 到配置的映射。 | map(map(string)) | 见下方示例 | 否 |

`topic_definitions` 示例：
```hcl
{
  topic1 = {
    remark     = "普通Topic"
    order_type = "0"
  }
  topic2 = {
    remark     = "顺序Topic"
    order_type = "1"
  }
}
```

`group_definitions` 示例：
```hcl
{
  "GID_consumer1" = {
    remark = "消费者组1"
  }
  "GID_consumer2" = {
    remark = "消费者组2"
  }
}
```

## 输出变量

| 名称 | 描述 |
|------|------|
| mqtt_instance_id | 创建的 MQTT 实例 ID。 |
| mqtt_instance_name | 创建的 MQTT 实例名称。 |
| mqtt_topic_names | 创建的 Topic 名称列表。 |
| mqtt_group_ids | 创建的 Group ID 列表。 |

## 注意事项

- `store_instance_id` 对应的 RocketMQ 实例必须已在您的账号中存在。
- Group ID 必须以 `GID_` 或 `GID-` 开头。
- Topic 名称必须为 3-64 个字符，可包含字母、数字、连字符(-)、下划线(_)和正斜杠(/)。
