# 创建新的 ONS 和 MQTT 实例

本示例用于创建新的 ONS（RocketMQ）实例作为存储后端，同时创建新的 MQTT 实例并配置 Topic 和 Group。

> 注意：本示例会创建新的 ONS/RocketMQ 实例和 MQTT 实例。

## 使用方法

1. 通过 `terraform.tfvars` 或命令行配置变量：
   ```hcl
   instance_name = "my-mqtt"
   ons_name      = "my-ons"
   max_conn      = 2000
   max_sub       = 20000
   topic_definitions = {
     test_topic = {
       remark     = "测试Topic"
       order_type = "0"
     }
     order_topic = {
       remark     = "顺序Topic"
       order_type = "1"
     }
   }
   group_definitions = {
     "GID_test_group" = {
       remark = "测试Group"
     }
   }
   ```
2. 执行以下命令：
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. 清理资源：
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
| ONS 实例 | alibabacloudstack_ons_instance |
| MQTT 实例 | alibabacloudstack_mqtt_instance |
| MQTT Topic | alibabacloudstack_mqtt_topic |
| MQTT Group | alibabacloudstack_mqtt_group |

## 输入变量

| 名称 | 描述 | 类型 | 示例值 | 必需 |
|------|------|------|--------|------|
| instance_name | 要创建的 MQTT 实例名称。 | string | "tfmqtt1" | 是 |
| remark | MQTT 实例的备注。 | string | "测试实例" | 否 |
| ons_name | 要创建的 ONS 实例名称。默认为 `{instance_name}MQ`。 | string | "my-ons" | 否 |
| ons_remark | ONS 实例的备注。 | string | "ONS instance for MQTT" | 否 |
| ons_tps_receive_max | ONS 实例接收消息的最大 TPS。 | number | 500 | 否 |
| ons_tps_send_max | ONS 实例发送消息的最大 TPS。 | number | 500 | 否 |
| ons_topic_capacity | ONS 实例的 Topic 容量。 | number | 50 | 否 |
| ons_cluster | ONS 实例的集群名称。 | string | "cluster1" | 否 |
| ons_independent_naming | ONS 实例是否使用独立命名。 | string | "true" | 否 |
| max_conn | 最大连接数。 | number | 1000 | 否 |
| max_sub | 最大订阅数。 | number | 10000 | 否 |
| max_up_tps | 最大上行 TPS。 | number | 500 | 否 |
| max_down_tps | 最大下行 TPS。 | number | 1000 | 否 |
| independent_naming | 是否使用独立命名空间。 | bool | true | 否 |
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

- 本示例会创建新的 ONS 实例，请确保您有足够的资源配额。
- Group ID 必须以 `GID_` 或 `GID-` 开头。
- Topic 名称必须为 3-64 个字符，可包含字母、数字、连字符(-)、下划线(_)和正斜杠(/)。
