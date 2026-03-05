# 阿里云 MQTT Terraform 模块

该模块用于在阿里云 Stack 上管理 MQTT 实例、Topic 和 Group。

## 支持资源

* [alibabacloudstack_mqtt_instance](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/mqtt_instance)
* [alibabacloudstack_mqtt_topic](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/mqtt_topic)
* [alibabacloudstack_mqtt_group](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/mqtt_group)

## 使用方法

### 场景 1：创建新的 MQTT 实例并配置 Topic 和 Group

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
    "GID_consumer2" = {
      remark = "消费者组2"
    }
  }
}
```

### 场景 2：为现有 MQTT 实例创建 Topic 和 Group

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

  group_definitions = {
    "GID_new_group" = {
      remark = "新Group"
    }
  }
}
```

### 场景 3：使用自动创建的 ONS 实例创建 MQTT 实例

```hcl
module "mqtt" {
  source = "./terraform-alibabacloudstack-mqtt"

  name                = "my-mqtt-instance"
  remark              = "Terraform managed MQTT instance"
  create_ons_instance = true
  ons_name            = "my-ons-instance"
  
  topic_definitions = {
    topic1 = {
      remark     = "普通Topic"
      order_type = "0"
    }
  }

  group_definitions = {
    "GID_consumer1" = {
      remark = "消费者组1"
    }
  }
}
```

> ⚠️ **关键约束**：
> - `mqtt_instance_id` 和 `name` **必须设置且仅能设置一个**。
> - 创建新 MQTT 实例时，`store_instance_id` 或 `create_ons_instance` 是必需的。

## 要求

| 名称 | 版本 |
|------|------|
| terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| **mqtt_instance_id** | **现有 MQTT 实例的 ID。如果设置，则不会创建新实例，并忽略 `name`。** | `string` | `""` | 否 |
| **name** | **新 MQTT 实例的名称。仅在 `mqtt_instance_id` 未设置时使用。** | `string` | `""` | 否 |
| remark | MQTT 实例的备注 | `string` | `""` | 否 |
| max_conn | 最大连接数 | `number` | `1000` | 否 |
| max_sub | 最大订阅数 | `number` | `10000` | 否 |
| max_up_tps | 最大上行 TPS | `number` | `500` | 否 |
| max_down_tps | 最大下行 TPS | `number` | `1000` | 否 |
| independent_naming | 是否使用独立命名空间 | `bool` | `true` | 否 |
| store_instance_id | 存储实例 ID（RocketMQ 实例 ID）。创建新实例时需要。 | `string` | `""` | 否 |
| topic_definitions | Topic 名称到其配置的映射 | `map(object)` | `{}` | 否 |
| group_definitions | Group ID 到其配置的映射 | `map(object)` | `{}` | 否 |

> 💡 **互斥规则**：
> - `mqtt_instance_id` 和 `name`：二选一
> - 当 `mqtt_instance_id` 未设置时，`store_instance_id` 是必需的

## 输出变量

| 名称 | 描述 |
|------|------|
| mqtt_instance_id | MQTT 实例 ID（无论是新建还是已有） |
| mqtt_instance_name | MQTT 实例名称 |
| mqtt_topic_names | 创建的 MQTT Topic 名称列表 |
| mqtt_group_ids | 创建的 MQTT Group ID 列表 |

## 注意事项

* 创建新 MQTT 实例时，`store_instance_id`（RocketMQ 实例 ID）是必需的。
* Group ID 必须以 `GID_` 或 `GID-` 开头。
* Topic 名称必须为 3-64 个字符，可包含字母、数字、连字符(-)、下划线(_)和正斜杠(/)。

## 提交问题

如果您在使用此模块时遇到任何问题，请提交 [provider issue](https://github.com/aliyun/terraform-provider-alibabacloudstack/issues/new) 并告知我们。

**注意：** 不建议在此仓库上提交 issue。

## 作者

由阿里云 Terraform 团队创建和维护

## 许可证

MIT 许可证。详情请参见 LICENSE。

## 参考

* [Terraform-Provider-Alibabacloudstack Github](https://github.com/aliyun/terraform-provider-alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack Release](https://registry.terraform.io/providers/aliyun/alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack 文档](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs)
