# 阿里云核心服务 API 操作映射知识库

> **版本**: v2.1 | **更新日期**: 2025-01-16

## 📖 快速索引

| 分类 | 服务 | 核心资源 | 查询复杂度 |
|------|------|----------|------------|
| 🖥️ **计算** | [ECS](#1-ecs-弹性计算服务) | Instance, Disk, SecurityGroup | ⭐⭐⭐ |
| 🗄️ **数据库** | [RDS](#2-rds-关系型数据库) | DBInstance, Database | ⭐⭐ |
| 🗄️ **数据库** | [Redis](#3-redis-缓存数据库) | Instance, Account | ⭐⭐ |
| 🗄️ **数据库** | [MongoDB](#4-mongodb-文档数据库) | DBInstance | ⭐ |
| 🗄️ **数据库** | [PolarDB](#5-polardb-云原生数据库) | DBCluster, DBNode | ⭐⭐ |
| ⚖️ **负载均衡** | [SLB](#6-slb-传统负载均衡) | LoadBalancer, Listener | ⭐⭐ |
| ⚖️ **负载均衡** | [ALB](#7-alb-应用型负载均衡) | LoadBalancer, Listener | ⭐⭐ |
| 🌐 **网络** | [VPC](#8-vpc-专有网络) | Vpc, VSwitch, RouteTable | ⭐⭐⭐ |
| 📦 **存储** | [OSS](#9-oss-对象存储) | Bucket, Object | ⭐ |
| 📁 **存储** | [NAS](#10-nas-文件存储) | FileSystem, MountTarget | ⭐ |
| 🌐 **网络** | [EIP](#11-eip-弹性公网ip) | Allocation | ⭐ |
| ⚡ **计算** | [FC](#12-fc-函数计算) | Service, Function | ⭐⭐ |
| 🐳 **容器** | [ACK](#13-ack-容器服务) | Cluster | ⭐ |
| 📨 **消息队列** | [RocketMQ/Kafka](#14-rocketmq--15-kafka-消息队列) | Instance, Topic | ⭐⭐ |
| 🌐 **网络** | [DNS](#16-dns-云解析) | Domain, Record | ⭐ |
| 📊 **监控** | [SLS](#17-sls-日志服务) | Project, LogStore | ⭐⭐ |
| 📊 **监控** | [CMS](#18-cms-云监控) | Metric, Alarm | ⭐⭐⭐ |
| 🛡️ **安全** | [WAF](#19-waf-web应用防火墙) | Domain, Rule | ⭐⭐ |
| 🛡️ **安全** | [DDoS](#20-ddos-防护) | Instance, AttackEvent | ⭐⭐ |
| 🌐 **网络** | [CDN](#21-cdn-内容分发网络) | Domain, Config | ⭐⭐ |

---

## API-Action 映射矩阵

### 1. ECS (弹性计算服务)

核心资源: 实例(Instance)、云盘(Disk)、安全组(SecurityGroup)、镜像(Image)、快照(Snapshot)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|查询地域列表|DescribeRegions|-|aliyun ecs DescribeRegions|
|单实例详情  (查看、详情、状态、配置) |DescribeInstances / DescribeInstanceAttribute|InstanceIds: `["i-bp1xxxx"]`<br>RegionId: `cn-hangzhou`|aliyun ecs DescribeInstances --InstanceIds '["i-xxx"]'|
|列表查询  (列出、所有、有哪些、批量) |DescribeInstances|RegionId: `cn-hangzhou`<br>Status: `Running` / `Stopped`<br>InstanceType: `ecs.g6.large`<br>VpcId: `vpc-xxxx`<br>PageSize: `50` (1-100)|aliyun ecs DescribeInstances --Status Running|
|查询实例监控数据 |DescribeInstanceMonitorData|InstanceId: `i-bp1xxxx`<br>RegionId: `cn-hangzhou`<br>Period: `60` (秒)<br>StartTime: `2024-01-01T00:00:00Z`<br>EndTime: `2024-01-01T01:00:00Z`|aliyun ecs DescribeInstanceMonitorData --InstanceId i-xxx|
|查询实例挂载的磁盘 |DescribeDisks|InstanceId: `i-bp1xxxx`<br>RegionId: `cn-hangzhou`<br>DiskIds: `["d-xxxx"]`<br>Status: `In_use` / `Available`|aliyun ecs DescribeDisks --InstanceId i-xxx|
|查询实例的安全组 |DescribeInstanceAttribute (解析SecurityGroupIds字段) |InstanceId: `i-bp1xxxx`<br>RegionId: `cn-hangzhou`|aliyun ecs DescribeInstanceAttribute --InstanceId i-xxx|
|查询安全组列表|DescribeSecurityGroups|SecurityGroupId: `sg-xxxx`<br>RegionId: `cn-hangzhou`<br>VpcId: `vpc-xxxx`<br>PageSize: `50`|aliyun ecs DescribeSecurityGroups --RegionId cn-hangzhou|
|查询安全组规则详情|DescribeSecurityGroupAttribute|SecurityGroupId: `sg-xxxx`<br>RegionId: `cn-hangzhou`<br>Direction: `ingress` / `egress`|aliyun ecs DescribeSecurityGroupAttribute --SecurityGroupId sg-xxx|
|查询镜像|DescribeImages|ImageId: `m-xxxx`<br>RegionId: `cn-hangzhou`<br>ImageName: `my-image`<br>Status: `Available`<br>ImageOwnerAlias: `self` / `system`|aliyun ecs DescribeImages --RegionId cn-hangzhou|
|查询快照|DescribeSnapshots|SnapshotId: `s-xxxx`<br>RegionId: `cn-hangzhou`<br>DiskId: `d-xxxx`<br>SourceDiskId: `d-xxxx`<br>Status: `accomplished`|aliyun ecs DescribeSnapshots --RegionId cn-hangzhou|

### 2. RDS (关系型数据库)

核心资源: 实例(DBInstance)、数据库(Database)、账号(Account)、备份(Backup)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|单实例详情  (数据库详情、连接信息) |DescribeDBInstanceAttribute|DBInstanceId: `rm-xxxx`|aliyun rds DescribeDBInstanceAttribute --DBInstanceId rm-xxx|
|列表查询  (列出数据库实例)|DescribeDBInstances|RegionId: `cn-beijing`<br>DBInstanceId: `rm-xxxx`<br>DBInstanceStatus: `Running`<br>DBInstanceType: `Primary` / `Readonly` / `Guard`<br>Engine: `MySQL` / `PostgreSQL` / `SQLServer`|aliyun rds DescribeDBInstances --RegionId cn-beijing|
|查询实例性能监控 |DescribeDBInstancePerformance (历史)  或 CMS API|DBInstanceId: `rm-xxxx`<br>Key: `MySQL_Sessions` / `MySQL_MemCpuUsage`<br>StartTime: `2024-01-01T00:00:00Z`<br>EndTime: `2024-01-01T01:00:00Z`|aliyun rds DescribeDBInstancePerformance --DBInstanceId rm-xxx|
|查询实例下的数据库|DescribeDatabases|DBInstanceId: `rm-xxxx`<br>DBName: `mydb`|aliyun rds DescribeDatabases --DBInstanceId rm-xxx|
|查询实例账号|DescribeAccounts|DBInstanceId: `rm-xxxx`<br>AccountName: `testuser`|aliyun rds DescribeAccounts --DBInstanceId rm-xxx|
|查询备份集|DescribeBackups|DBInstanceId: `rm-xxxx`<br>BackupId: `xxxx`<br>StartTime: `2024-01-01T00:00:00Z`<br>EndTime: `2024-01-02T00:00:00Z`<br>BackupStatus: `Success`|aliyun rds DescribeBackups --DBInstanceId rm-xxx|

### 3. Redis (缓存数据库)

核心资源: 实例(Instance)、账号(Account)、备份(Backup)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|单实例详情 |DescribeInstanceAttribute|InstanceId: `r-xxxx`|aliyun r-kvstore DescribeInstanceAttribute --InstanceId r-xxx|
|列表查询|DescribeInstances|RegionId: `cn-hangzhou`<br>InstanceId: `r-xxxx`<br>InstanceStatus: `Running` / `Flushing`<br>InstanceType: `Redis` / `Memcache`<br>ArchitectureType: `cluster` / `standard`<br>PageSize: `30`|aliyun r-kvstore DescribeInstances --RegionId cn-hangzhou|
|查询实例监控|CMS API (DescribeMetricList)|Namespace: `acs_kvstore`<br>MetricName: `IntranetInRatio` / `CpuUsage`<br>Dimensions: `{"instanceId": "r-xxxx"}`<br>Period: `60`|aliyun cms DescribeMetricList --Namespace acs_kvstore|
|查询实例账号|DescribeAccounts|InstanceId: `r-xxxx`<br>AccountName: `testuser`|aliyun r-kvstore DescribeAccounts --InstanceId r-xxx|
|查询备份|DescribeBackups|InstanceId: `r-xxxx`<br>StartTime: `2024-01-01T00:00:00Z`<br>EndTime: `2024-01-02T00:00:00Z`<br>BackupId: `xxxx`|aliyun r-kvstore DescribeBackups --InstanceId r-xxx|

### 4. MongoDB (文档数据库)

核心资源: 实例(DBInstance)、备份(Backup)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|单实例详情 |DescribeDBInstanceAttribute|DBInstanceId: `dds-xxxx`|aliyun dds DescribeDBInstanceAttribute --DBInstanceId dds-xxx|
|列表查询|DescribeDBInstances|RegionId: `cn-shanghai`<br>DBInstanceId: `dds-xxxx`<br>DBInstanceStatus: `Running`<br>DBInstanceType: `replicate` / `sharding` / `single`<br>PageSize: `30`|aliyun dds DescribeDBInstances --RegionId cn-shanghai|
|查询备份策略/集|DescribeBackupPolicy / DescribeBackups|DBInstanceId: `dds-xxxx`<br>BackupId: `xxxx`|aliyun dds DescribeBackupPolicy --DBInstanceId dds-xxx|

### 5. PolarDB (云原生数据库)

核心资源: 集群(DBCluster)、节点(DBNode)、数据库(Database)、账号(Account)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|集群详情|DescribeDBClusterAttribute|DBClusterId: `pc-xxxx`|aliyun polardb DescribeDBClusterAttribute --DBClusterId pc-xxx|
|集群列表|DescribeDBClusters|RegionId: `cn-hangzhou`<br>DBClusterId: `pc-xxxx`<br>DBClusterStatus: `Running`<br>DBType: `MySQL` / `PostgreSQL` / `Oracle`<br>PageSize: `30`|aliyun polardb DescribeDBClusters --RegionId cn-hangzhou|
|查询集群节点|DescribeDBNodes|DBClusterId: `pc-xxxx`<br>DBNodeId: `pn-xxxx`|aliyun polardb DescribeDBNodes --DBClusterId pc-xxx|
|查询数据库|DescribeDatabases|DBClusterId: `pc-xxxx`<br>DBName: `mydb`|aliyun polardb DescribeDatabases --DBClusterId pc-xxx|
|查询账号|DescribeAccounts|DBClusterId: `pc-xxxx`<br>AccountName: `testuser`|aliyun polardb DescribeAccounts --DBClusterId pc-xxx|

### 6. SLB (传统负载均衡)

核心资源: 实例(LoadBalancer)、监听(Listener)、后端服务器(BackendServer)、虚拟服务器组(VServerGroup)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|实例列表|DescribeLoadBalancers|RegionId: `cn-hangzhou`<br>LoadBalancerId: `lb-xxxx`<br>Address: `192.168.1.1`<br>LoadBalancerName: `my-slb`<br>PageSize: `50`|aliyun slb DescribeLoadBalancers --RegionId cn-hangzhou|
|实例详情|DescribeLoadBalancerAttribute|LoadBalancerId: `lb-xxxx`<br>RegionId: `cn-hangzhou`|aliyun slb DescribeLoadBalancerAttribute --LoadBalancerId lb-xxx|
|查询监听列表|DescribeLoadBalancerListeners|LoadBalancerId: `lb-xxxx`<br>RegionId: `cn-hangzhou`<br>ListenerPort: `80`<br>Protocol: `http` / `https` / `tcp` / `udp`|aliyun slb DescribeLoadBalancerListeners --LoadBalancerId lb-xxx|
|查询TCP监听配置|DescribeLoadBalancerTCPListenerAttribute|LoadBalancerId: `lb-xxxx`<br>ListenerPort: `80`<br>RegionId: `cn-hangzhou`|aliyun slb DescribeLoadBalancerTCPListenerAttribute --LoadBalancerId lb-xxx --ListenerPort 80|
|查询UDP监听配置|DescribeLoadBalancerUDPListenerAttribute|LoadBalancerId: `lb-xxxx`<br>ListenerPort: `80`<br>RegionId: `cn-hangzhou`|aliyun slb DescribeLoadBalancerUDPListenerAttribute --LoadBalancerId lb-xxx --ListenerPort 80|
|查询HTTP监听配置|DescribeLoadBalancerHTTPListenerAttribute|LoadBalancerId: `lb-xxxx`<br>ListenerPort: `80`<br>RegionId: `cn-hangzhou`|aliyun slb DescribeLoadBalancerHTTPListenerAttribute --LoadBalancerId lb-xxx --ListenerPort 80|
|查询HTTPS监听配置|DescribeLoadBalancerHTTPSListenerAttribute|LoadBalancerId: `lb-xxxx`<br>ListenerPort: `443`<br>RegionId: `cn-hangzhou`|aliyun slb DescribeLoadBalancerHTTPSListenerAttribute --LoadBalancerId lb-xxx --ListenerPort 443|
|查询后端服务器健康状态|DescribeHealthStatus|LoadBalancerId: `lb-xxxx`<br>ListenerPort: `80`<br>RegionId: `cn-hangzhou`|aliyun slb DescribeHealthStatus --LoadBalancerId lb-xxx|
|查询转发规则|DescribeRules / DescribeRuleAttribute|LoadBalancerId: `lb-xxxx`<br>RuleId: `rule-xxxx`<br>ListenerPort: `80`|aliyun slb DescribeRules --LoadBalancerId lb-xxx|
|查询虚拟服务器组列表|DescribeVServerGroups|LoadBalancerId: `lb-xxxx`<br>RegionId: `cn-hangzhou`<br>VServerGroupId: `vsp-xxxx`|aliyun slb DescribeVServerGroups --LoadBalancerId lb-xxx|
|查询虚拟服务器组详情|DescribeVServerGroupAttribute|VServerGroupId: `vsp-xxxx`<br>RegionId: `cn-hangzhou`|aliyun slb DescribeVServerGroupAttribute --VServerGroupId vsp-xxx|
|查询访问控制策略组列表|DescribeAccessControlLists|AclId: `acl-xxxx`<br>RegionId: `cn-hangzhou`<br>PageSize: `50`|aliyun slb DescribeAccessControlLists --RegionId cn-hangzhou|
|查询访问控制策略组配置|DescribeAccessControlListAttribute|AclId: `acl-xxxx`<br>RegionId: `cn-hangzhou`|aliyun slb DescribeAccessControlListAttribute --AclId acl-xxx|

---

### 7. ALB (应用型负载均衡)

核心资源: 实例(LoadBalancer)、监听(Listener)、服务器组(ServerGroup)、规则(Rule)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|实例列表|ListLoadBalancers|RegionId: `cn-hangzhou`<br>LoadBalancerId: `alb-xxxx`<br>Address: `192.168.1.1`<br>LoadBalancerName: `my-alb`<br>PageSize: `50`|aliyun alb ListLoadBalancers --RegionId cn-hangzhou|
|实例详情|GetLoadBalancerAttribute|LoadBalancerId: `alb-xxxx`<br>RegionId: `cn-hangzhou`|aliyun alb GetLoadBalancerAttribute --LoadBalancerId alb-xxx|
|查询监听列表|ListListeners|LoadBalancerId: `alb-xxxx`<br>RegionId: `cn-hangzhou`<br>ListenerId: `lsn-xxxx`|aliyun alb ListListeners --LoadBalancerId alb-xxx|
|查询监听属性|GetListenerAttribute|ListenerId: `lsn-xxxx`<br>RegionId: `cn-hangzhou`|aliyun alb GetListenerAttribute --ListenerId lsn-xxx|
|查询健康检查状态|GetListenerHealthStatus|ListenerId: `lsn-xxxx`<br>RegionId: `cn-hangzhou`|aliyun alb GetListenerHealthStatus --ListenerId lsn-xxx|
|查询服务器组列表|ListServerGroups|RegionId: `cn-hangzhou`<br>ServerGroupId: `sgp-xxxx`<br>ServerGroupName: `my-sg`<br>PageSize: `50`|aliyun alb ListServerGroups --RegionId cn-hangzhou|
|查询服务器组服务器列表|ListServerGroupServers|ServerGroupId: `sgp-xxxx`<br>RegionId: `cn-hangzhou`|aliyun alb ListServerGroupServers --ServerGroupId sgp-xxx|
|查询转发规则|ListRules|ListenerId: `lsn-xxxx`<br>RegionId: `cn-hangzhou`<br>RuleIds: `["rule-xxxx"]`|aliyun alb ListRules --ListenerId lsn-xxx|
|查询访问控制列表|ListAcls|AclId: `acl-xxxx`<br>RegionId: `cn-hangzhou`|aliyun alb ListAcls --RegionId cn-hangzhou|
|查询访问控制条目|ListAclEntries|AclId: `acl-xxxx`<br>RegionId: `cn-hangzhou`|aliyun alb ListAclEntries --AclId acl-xxx|
|查询访问控制关联关系|ListAclRelations|AclId: `acl-xxxx`<br>RegionId: `cn-hangzhou`|aliyun alb ListAclRelations --AclId acl-xxx|

### 8. VPC (专有网络)

核心资源: VPC、交换机(VSwitch)、路由表(RouteTable)、安全组(SecurityGroup)、弹性网卡(ENI)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|VPC列表|DescribeVpcs|RegionId: `cn-beijing`<br>VpcId: `vpc-xxxx`<br>VpcName: `my-vpc`<br>PageSize: `50`|aliyun vpc DescribeVpcs --RegionId cn-beijing|
|VPC详情|DescribeVpcAttribute|VpcId: `vpc-xxxx`<br>RegionId: `cn-beijing`|aliyun vpc DescribeVpcAttribute --VpcId vpc-xxx|
|查询VPC下的交换机 |DescribeVSwitches|VpcId: `vpc-xxxx`<br>RegionId: `cn-beijing`<br>VSwitchId: `vsw-xxxx`<br>PageSize: `50`|aliyun vpc DescribeVSwitches --VpcId vpc-xxx|
|查询路由表|DescribeRouteTables|RouteTableId: `vtb-xxxx`<br>VpcId: `vpc-xxxx`<br>RegionId: `cn-beijing`|aliyun vpc DescribeRouteTables --RouteTableId vtb-xxx|
|查询弹性网卡|DescribeNetworkInterfaces|NetworkInterfaceId: `eni-xxxx`<br>InstanceId: `i-xxxx`<br>VSwitchId: `vsw-xxxx`<br>PageSize: `50`|aliyun vpc DescribeNetworkInterfaces --InstanceId i-xxx|
|查询VPC内资源拓扑 |DescribeVpcAttachedResources (BETA)|VpcId: `vpc-xxxx`<br>ResourceType: `VSwitch` / `RouteTable`|aliyun vpc DescribeVpcAttachedResources --VpcId vpc-xxx|

### 9. OSS (对象存储)

核心资源: 存储桶(Bucket)、对象(Object)、生命周期(Lifecycle)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|查询Bucket列表|ListBuckets|- (无地域参数，全局)|aliyun oss ls|
|查询Bucket详情/配置|GetBucketInfo / GetBucketStat|Bucket: `mybucket`|aliyun oss stat oss://mybucket|
|列出Bucket内文件|ListObjects (V2)|Bucket: `mybucket`<br>Prefix: `path/`<br>MaxKeys: `100`<br>Delimiter: `/`|aliyun oss ls oss://mybucket|
|查询文件详情|GetObjectMeta|Bucket: `mybucket`<br>Object: `path/to/object`|aliyun oss stat oss://mybucket/object|
|查询Bucket生命周期规则|GetBucketLifecycle|Bucket: `mybucket`|aliyun oss lifecycle get oss://mybucket|

### 10. NAS (文件存储)

核心资源: 文件系统(FileSystem)、挂载点(MountTarget)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|文件系统列表|DescribeFileSystems|RegionId: `cn-hangzhou`<br>FileSystemId: `31xxxx`<br>FileSystemType: `standard` / `extreme` / `cpfs`|aliyun nas DescribeFileSystems --RegionId cn-hangzhou|
|文件系统详情|DescribeFileSystems (通过ID)|FileSystemId: `31xxxx`<br>RegionId: `cn-hangzhou`|aliyun nas DescribeFileSystems --FileSystemId 31xxx|
|查询挂载点|DescribeMountTargets|FileSystemId: `31xxxx`<br>RegionId: `cn-hangzhou`<br>MountTargetDomainName: `xxxx.cn-hangzhou.nas.aliyuncs.com`|aliyun nas DescribeMountTargets --FileSystemId 31xxx|

### 11. EIP (弹性公网IP)

核心资源: 地址(Allocation)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|EIP列表|DescribeEipAddresses|RegionId: `cn-hangzhou`<br>AllocationId: `eip-xxxx`<br>AssociatedInstanceId: `i-xxxx`<br>Status: `Available` / `InUse`<br>PageSize: `50`|aliyun vpc DescribeEipAddresses --RegionId cn-hangzhou|
|EIP详情|DescribeEipAddresses (通过ID)|AllocationId: `eip-xxxx`<br>RegionId: `cn-hangzhou`|aliyun vpc DescribeEipAddresses --AllocationId eip-xxx|

### 12. FC (函数计算)

核心资源: 服务(Service)、函数(Function)、触发器(Trigger)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|服务列表/详情|ListServices / GetService|ServiceName: `my-service`<br>RegionId: `cn-hangzhou`|aliyun fc ListServices --RegionId cn-hangzhou|
|函数列表/详情|ListFunctions / GetFunction|ServiceName: `my-service`<br>FunctionName: `my-func`<br>RegionId: `cn-hangzhou`|aliyun fc ListFunctions --ServiceName my-service|
|触发器列表|ListTriggers|ServiceName: `my-service`<br>FunctionName: `my-func`<br>TriggerName: `my-trigger`|aliyun fc ListTriggers --ServiceName my-service --FunctionName my-func|

### 13. ACK (容器服务)

核心资源: 集群(Cluster)，需要结合kubectl或调用k8s API进行更细粒度查询。

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|集群列表/详情|DescribeClusters / DescribeClusterDetail|ClusterId: `c-xxxx`<br>RegionId: `cn-hangzhou`<br>Name: `my-cluster`<br>ClusterType: `Kubernetes` / `ASK` / `Serverless`|aliyun cs DescribeClusters --RegionId cn-hangzhou|
|查询集群节点|DescribeClusterNodes|ClusterId: `c-xxxx`<br>RegionId: `cn-hangzhou`|aliyun cs DescribeClusterNodes --ClusterId c-xxx|

### 14. RocketMQ & 15. Kafka (消息队列)

**RocketMQ** 核心资源: 实例(Instance)、Topic、Group
**Kafka** 核心资源: 实例(Instance)、Topic

|用户意图 / 查询关键词|对应阿里云API操作 (RocketMQ)|对应阿里云API操作 (Kafka)|主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|---|
|实例列表/详情|ListInstances / GetInstance|GetInstanceList / GetInstance|RegionId: `cn-hangzhou`<br>InstanceId: `MQS_xxx` / `alikafka_xxx`|aliyun mq ListInstances --RegionId cn-hangzhou|
|Topic列表/详情|ListTopics / GetTopic|GetTopicList / GetTopic|InstanceId: `MQS_xxx`<br>Topic: `my-topic`|aliyun mq ListTopics --InstanceId MQS_xxx|
|消费组列表 (RocketMQ)|ListConsumerGroups|N/A|InstanceId: `MQS_xxx`<br>Group: `my-group`|aliyun mq ListConsumerGroups --InstanceId MQS_xxx|

### 16. DNS (云解析)

核心资源: 域名(Domain)、解析记录(Record)、实例(Instance)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|域名列表|DescribeDomains|PageNumber: `1`<br>PageSize: `20`<br>KeyWord: `example`<br>GroupId: `xxxx`|aliyun alidns DescribeDomains|
|域名详情|DescribeDomainInfo|DomainName: `example.com`|aliyun alidns DescribeDomainInfo --DomainName example.com|
|实例绑定域名列表|DescribeInstanceDomains|InstanceId: `xxx`<br>PageNumber: `1`<br>PageSize: `20`|aliyun alidns DescribeInstanceDomains --InstanceId xxx|
|查询解析记录|DescribeDomainRecords|DomainName: `example.com`<br>RRKeyWord: `www`<br>TypeKeyWord: `A` / `CNAME`<br>PageNumber: `1`|aliyun alidns DescribeDomainRecords --DomainName example.com|

### 17. SLS (日志服务)

核心资源: 项目(Project)、日志库(LogStore)、日志(Shard)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|
|---|---|---|
|项目列表|ListLogStores|RegionId: `cn-hangzhou`<br>ProjectName: `my-project`|
|日志库列表|ListLogStores|ProjectName: `my-project`<br>PageSize: `50`|
|查询日志|GetLogs / GetHistograms|ProjectName: `my-project`<br>LogStoreName: `my-logstore`<br>From: `1704067200` (时间戳)<br>To: `1704153600`<br>Query: `status:200` |

### 18. CMS (云监控)

核心资源: 指标(Metric)、报警规则(Alarm)、事件(Event)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|
|---|---|---|
|查询监控指标数据|DescribeMetricList|Namespace: `acs_ecs` / `acs_rds`<br>MetricName: `CPUUtilization`<br>Dimensions: `{"instanceId": "i-xxxx"}`<br>Period: `60` (秒)<br>StartTime: `2024-01-01T00:00:00Z`<br>EndTime: `2024-01-01T01:00:00Z`|
|查询报警规则列表|DescribeMetricRuleList|RuleId: `alert-xxxx`<br>RuleName: `my-alert`<br>Namespace: `acs_ecs`<br>PageSize: `50`|
|查询监控事件|DescribeSystemEventHistogram / DescribeSystemEventAttribute|Product: `ECS` / `RDS`<br>EventType: `StatusNotification` / `Maintenance`<br>StartTime: `2024-01-01T00:00:00Z`<br>EndTime: `2024-01-02T00:00:00Z`|

### 19. WAF (Web应用防火墙)

核心资源: 域名(Domain)、防护规则(Rule)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|
|---|---|---|
|防护域名列表|DescribeDomainNames|InstanceId: `xxxx`<br>Region: `cn`<br>Domain: `example.com`|
|查询防护配置/日志|DescribeProtectionModuleStatus / DescribeLogs|InstanceId: `xxxx`<br>Domain: `example.com`<br>ModuleName: `waf_group` / `cc`|

### 20. DDoS (DDoS防护)

核心资源: 实例(Instance)、攻击事件(AttackEvent)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|实例列表/详情|DescribeInstances|InstanceId: `ddoscoo-xxxx`<br>Region: `cn-hangzhou`|aliyun ddoscoo DescribeInstances --RegionId cn-hangzhou|
|查询攻击事件|DescribeDDoSEvents|InstanceId: `ddoscoo-xxxx`<br>StartTime: `2024-01-01T00:00:00Z`<br>EndTime: `2024-01-02T00:00:00Z`|aliyun ddoscoo DescribeDDoSEvents --InstanceId xxx|

---

### 21. CDN (内容分发网络)

核心资源: 域名(Domain)、配置(Config)

|用户意图 / 查询关键词|对应阿里云API操作 |主要参数示例|CLI命令参考 (简化)|
|---|---|---|---|
|查询用户域名|DescribeUserDomains|DomainName: `example.com`<br>PageSize: `50`<br>PageNumber: `1`<br>CdnType: `web` / `download` / `video`|aliyun cdn DescribeUserDomains|
|查询域名详情|DescribeCdnDomainDetail|DomainName: `example.com`|aliyun cdn DescribeCdnDomainDetail --DomainName example.com|
|查询域名配置|DescribeCdnDomainConfigs|DomainName: `example.com`<br>FunctionNames: `ipv6_switch` / `optimize_enable`|aliyun cdn DescribeCdnDomainConfigs --DomainName example.com|

---

## 📚 附录：最佳实践与使用说明

### 1️⃣ AI Agent 集成指南

此映射表是构建"LLM意图理解层"和"脚本生成引擎"的关键参考。在实际AI Agent设计中：

| 阶段 | 说明 |
|------|------|
| **意图识别** | 当LLM识别出用户查询的服务（如"ECS"）、资源类型（如"实例"）和操作（如"查看详情"）后，应优先映射到此表中的标准化API操作 |
| **参数填充** | 根据实体识别模块提取的资源ID、地域、过滤条件等，填充对应API的必选和可选参数 |
| **命令生成** | 结合阿里云CLI的语法规则，将{API}和{参数}转换为可执行的命令行 |
| **结果处理** | 将API返回的原始JSON/XML数据，通过格式化层转换为用户友好的摘要、表格或图表 |

### 2️⃣ CLI 命令执行模式

```bash
# 基础查询模式
aliyun {service} {api} --param1 value1 --param2 value2

# 示例
aliyun ecs DescribeInstances --RegionId cn-hangzhou --Status Running

# JSON 输出格式（推荐自动化处理）
aliyun ecs DescribeInstances --RegionId cn-hangzhou --Output json

# 指定输出文件
aliyun ecs DescribeInstances --RegionId cn-hangzhou > output.json
```

### 3️⃣ 常见参数说明

| 参数名 | 说明 | 常见值 |
|--------|------|--------|
| `RegionId` | 地域ID | cn-hangzhou, cn-beijing, cn-shanghai |
| `InstanceId` | 实例ID | i-bp1xxxxxx |
| `PageSize/PageNumber` | 分页参数 | 10-100 (默认50) |
| `Status` | 资源状态 | Running, Stopped, Starting |

### 4️⃣ 错误处理与最佳实践

**常见错误码**:
- `InvalidParameter` - 参数格式错误
- `AuthFailed` - 认证失败
- `Throttling` - 请求频率超限

**最佳实践**:
1. ✅ 使用 `--RegionId` 显式指定地域
2. ✅ 大量数据查询时使用分页参数
3. ✅ 敏感操作前先执行 `Describe` 查询确认
4. ✅ 定期检查 API 版本更新公告

### 5️⃣ 版本更新记录

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| v2.1 | 2025-01-16 | 全面完善所有服务的"主要参数"列；添加参数值示例和可选值说明 |
| v2.0 | 2025-01-16 | 新增 CDN 服务；优化表格格式；补充 CLI 示例；添加快速索引 |
| v1.0 | 2024-xx-xx | 初始版本，涵盖 20+ 核心服务 |

---

> ⚠️ **重要提示**: 阿里云API会持续更新，具体参数和可用性请以 https://api.aliyun.com/ 为准。建议系统设计时加入API元数据管理机制，以支持动态更新。

