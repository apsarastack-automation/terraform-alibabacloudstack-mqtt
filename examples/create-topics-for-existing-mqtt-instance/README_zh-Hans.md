# 为现有 MQTT 实例创建 Topic 和 Group

此 Terraform 示例用于**在已存在的阿里云 MQTT 实例上创建一个或多个 Topic 和 Group**。  
它调用 `mqtt_instance` 模块，仅执行 Topic 和 Group 创建操作，**不会创建新的 MQTT 实例**。

## 使用方法

1. 确保已存在一个 MQTT 实例（例如 `mqtt-xxxxxxxx`）
2. 配置变量（通过 `terraform.tfvars` 或命令行）：
   ```hcl
   mqtt_instance_id = "mqtt-xxxxxxxx"
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
     "GID_consumer1" = {
       remark = "消费者组1"
     }
     "GID_consumer2" = {
       remark = "消费者组2"
     }
   }
   ```
3. 执行以下命令：
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. 清理资源（仅删除 Topic 和 Group，不影响 MQTT 实例）：
   ```bash
   terraform destroy
   ```

> ⚠️ **注意**：此操作**不会删除或修改 MQTT 实例本身**，仅管理其下的 Topic 和 Group。

## 要求

| 名称 | 版本 |
|------|------|
| Terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 模块依赖

| 模块名称 | 来源路径 |
|----------|----------|
| `mqtt_instance` | `../../modules/mqtt_instance` |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| `mqtt_instance_id` | **已存在的 MQTT 实例 ID** | `string` | - | 是 |
| `topic_definitions` | Topic 名称到配置的映射（格式：`{ topic_name = { remark = "", order_type = "0" } }`） | `map(map(string))` | `{}` | 否 |
| `group_definitions` | Group ID 到配置的映射（格式：`{ "GID_xxx" = { remark = "" } }`） | `map(map(string))` | `{}` | 否 |

> 💡 **order_type 支持值**：`"0"`（普通），`"1"`（顺序）

## 输出变量

| 名称 | 描述 |
|------|------|
| `mqtt_instance_id` | 所操作的 MQTT 实例 ID |
| `mqtt_instance_name` | 所操作的 MQTT 实例名称 |
| `mqtt_topic_names` | 实际创建的 Topic 名称列表 |
| `mqtt_group_ids` | 实际创建的 Group ID 列表 |

## 注意事项

- 此示例**假设 MQTT 实例已存在**，如果 `mqtt_instance_id` 对应的实例不存在，Terraform 将报错。
- 删除资源（`terraform destroy`）**仅删除通过本配置创建的 Topic 和 Group**，不会影响 MQTT 实例或其他资源。
- Group ID 必须以 `GID_` 或 `GID-` 开头。
- Topic 名称必须为 3-64 个字符，可包含字母、数字、连字符(-)、下划线(_)和正斜杠(/)。

## 参考

- [MQTT Topic 管理文档](https://help.aliyun.com/document_detail/29532.html)
- [alibabacloudstack_mqtt_topic 资源](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/mqtt_topic)
- [alibabacloudstack_mqtt_group 资源](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/mqtt_group)
