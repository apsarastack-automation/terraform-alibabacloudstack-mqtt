# 阿里云 MQTT Terraform 模块

该模块用于在阿里云 Stack 上创建 **MQTT 实例、Topic 和 Group**。

## 功能特性

- 创建新的 MQTT 实例
- 自动创建一个或多个 MQTT Topic（通过 `topic_definitions` 定义）
- 自动创建一个或多个 MQTT Group（通过 `group_definitions` 定义）
- 支持使用已有的 MQTT 实例

> ⚠️ **注意**：本模块支持创建新 MQTT 实例，也支持使用已有实例（通过 `mqtt_instance_id`）。

## 使用方法

### 基础用法：创建 MQTT 实例并配置 Topic 和 Group

```hcl
module "mqtt" {
  source = "./terraform-alibabacloudstack-mqtt"

  name              = "my-mqtt-instance"
  remark            = "Terraform managed MQTT instance"
  store_instance_id = "ons-xxxxxxxx"

  topic_definitions = {
    topic1 = {
      remark     = "普通Topic"
      order_type = "0"
    }
    topic2 = {
      remark     = "顺序Topic"
      order_type = "1"
    }
  }

  group_definitions = {
    "GID_consumer1" = {
      remark = "消费者组1"
    }
  }
}
```

### 高级用法：使用已有 MQTT 实例

```hcl
module "mqtt" {
  source = "./terraform-alibabacloudstack-mqtt"

  mqtt_instance_id = "existing-mqtt-id"

  topic_definitions = {
    new_topic = {
      remark     = "新Topic"
      order_type = "0"
    }
  }
}
```

## 要求

| 名称 | 版本 |
|------|------|
| Terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| `mqtt_instance_id` | 已有 MQTT 实例的 ID | `string` | `""` | 否 |
| `name` | MQTT 实例名称 | `string` | `""` | 否 |
| `remark` | MQTT 实例备注 | `string` | `""` | 否 |
| `max_conn` | 最大连接数 | `number` | `1000` | 否 |
| `max_sub` | 最大订阅数 | `number` | `10000` | 否 |
| `max_up_tps` | 最大上行 TPS | `number` | `500` | 否 |
| `max_down_tps` | 最大下行 TPS | `number` | `1000` | 否 |
| `independent_naming` | 是否使用独立命名空间 | `bool` | `true` | 否 |
| `store_instance_id` | 存储实例 ID（RocketMQ 实例 ID） | `string` | `""` | 否 |
| `topic_definitions` | Topic 名称到配置的映射 | `map(object)` | `{}` | 否 |
| `group_definitions` | Group ID 到配置的映射 | `map(object)` | `{}` | 否 |

> 💡 **互斥规则**：`mqtt_instance_id` 或 `name` 必须设置一个。创建新实例时需要 `store_instance_id`。

## 输出变量

| 名称 | 描述 |
|------|------|
| `mqtt_instance_id` | MQTT 实例 ID |
| `mqtt_instance_name` | MQTT 实例名称 |
| `mqtt_topic_names` | 创建的 Topic 名称列表 |
| `mqtt_group_ids` | 创建的 Group ID 列表 |

## 示例

更多使用场景请参见 [`examples/`](./examples) 目录：
- `create-mqtt-instance-with-topics` - 使用已有ONS创建MQTT实例并配置Topic和Group
- `create-mqtt-instance-with-ons` - 使用已有ONS实例创建完整MQTT资源
- `create-topics-for-existing-mqtt-instance` - 为已有MQTT实例创建Topic和Group

## 注意事项

- 本模块可以创建新 MQTT 实例，也可以使用已有实例。
- Group ID 必须以 `GID_` 或 `GID-` 开头。
- Topic 名称必须为 3-64 个字符，可包含字母、数字、连字符(-)、下划线(_)和正斜杠(/)。
