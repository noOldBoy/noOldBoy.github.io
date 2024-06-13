---
title: mysql查询sql记录
date: 2022-12-02 11:37:13
tags:
- mysql
categories:
- 数据库
cover: /images/cha/30.jpeg
coverWidth: 1200
coverHeight: 320
---

msyql查询sql记录

<!-- more -->

#### sql拼接

##### 返回字段（Json）拼接

```mysql
SELECT
  "云服务器" AS type,
  t1.instance_name AS instanceName,
  t1.instance_id AS instanceId,
  "专有云" AS area,
  "阿里云" AS source,
  ( CASE `bill_status` WHEN 3 THEN '已释放' WHEN 4 THEN '已停机' ELSE '运行中' END ) AS `status`,
  t1.real_produce_time AS openTime,
  t1.releasing_time AS releaseTime,
  t3.allocate_time AS changeTime,
  CONCAT(
    '{',
    CONCAT_WS(
      ',',
      CONCAT( '"', 'vpcName', '":"', t2.vpc_name, '"' ),
      CONCAT( '"', 'vpcId', '":"', t2.vpc_code, '"' ),
      CONCAT( '"', 'ip', '":"', t1.private_network_ip, '"' ),
      CONCAT( '"', 'eip', '":"', t1.public_network_ip, '"' ),
      CONCAT( '"', 'cpu', '":"', t1.cpu_core_count, '"' ),
      CONCAT( '"', 'memory', '":"', t1.ram_size, '"' ),
      CONCAT( '"', 'natIp', '":"', t1.nat_ip, '"' ),
      CONCAT( '"', 'storage', '":"', ( SELECT sum( disk_size ) FROM resource_mgr_ecs_disk WHERE resource_mgr_ecs_id = t1.id AND disk_property = 2 ), '"' ),
      CONCAT( '"', 'osName', '":"', t1.operating_system_name, '"' ),
      CONCAT( '"', 'systemDiskSize', '":"', ( SELECT sum( disk_size ) FROM resource_mgr_ecs_disk WHERE resource_mgr_ecs_id = t1.id AND disk_property = 1 AND data_flag = 1 ), '"' ),
      CONCAT(
        '"',
        'systemDiskType',
        '":"',
        (
        SELECT
          ( CASE `disk_type` WHEN "cloud_efficiency" THEN 1 WHEN "cloud_ssd" THEN 2 ELSE 1 END ) AS diskType 
        FROM
          resource_mgr_ecs_disk 
        WHERE
          resource_mgr_ecs_id = t1.id 
          AND disk_property = 1 
          AND data_flag = 1 
        ),
        '"' 
      ) 
    ),
    '}' 
  ) AS adJson,
  t4.app_Id AS appId,
  t4.`name` AS appName 
FROM
  resource_mgr_ecs t1
  LEFT JOIN sys_vpc t2 ON t1.vpc_id = t2.id
  LEFT JOIN resource_mgr_dynamic_allocate t3 ON t3.resource_id = t1.id 
  AND t3.resource_type = 1 
  AND t3.id = ( SELECT id FROM resource_mgr_dynamic_allocate WHERE t1.id = t3.resource_id AND t3.resource_type = 1 ORDER BY allocate_time DESC LIMIT 1 )
  LEFT JOIN temp_irs_app_detail t4 ON t1.app_code = t4.`code` 
WHERE
  t1.dept_id = 842 
  OR t1.pay_dept_id = 842 
  AND t1.data_flag = 1 
  AND t1.bill_status != 4 UNION ALL
SELECT
  "云数据库" AS type,
  t1.ins_name AS instanceName,
  t1.instance_id AS instanceId,
  "专有云" AS area,
  "阿里云" AS source,
  ( CASE t1.`status` WHEN 4 THEN '已释放' ELSE '运行中' END ) AS `status`,
  t1.real_produce_time AS openTime,
  t1.releasing_time AS releaseTime,
  t4.allocate_time AS changeTime,
  CONCAT(
    '{',
    CONCAT_WS(
      ',',
      CONCAT( '"', 'engine', '":"', t1.db_type, '"' ),
      CONCAT( '"', 'iops', '":"', t1.max_iops, '"' ),
      CONCAT( '"', 'maxConnect', '":"', t2.max_connection, '"' ),
      CONCAT( '"', 'vpcId', '":"', t3.vpc_code, '"' ),
      CONCAT( '"', 'vpcName', '":"', t3.vpc_name, '"' ),
      CONCAT( '"', 'ip', '":"', t1.ip_addr, '"' ),
      CONCAT( '"', 'cpu', '":"', t1.cpu_core_count, '"' ),
      CONCAT( '"', 'memory', '":"', t1.ram_size, '"' ),
      CONCAT( '"', 'engineVersion', '":"', t1.db_version, '"' ),
      CONCAT( '"', 'storage', '":"', t1.storage_size, '"' ) 
    ),
    '}' 
  ) AS adJson,
  t5.app_Id AS appId,
  t5.`name` AS appName 
FROM
  resource_mgr_rds t1
  LEFT JOIN product_rds_type t2 ON t1.ins_type = t2.insType
  LEFT JOIN sys_vpc t3 ON t3.id = t1.vpc_id
  LEFT JOIN resource_mgr_dynamic_allocate t4 ON t4.resource_id = t1.id 
  AND t4.resource_type = 2 
  AND t4.id = ( SELECT id FROM resource_mgr_dynamic_allocate WHERE t1.id = t4.resource_id AND t4.resource_type = 1 ORDER BY allocate_time DESC LIMIT 1 )
  LEFT JOIN temp_irs_app_detail t5 ON t1.app_code = t5.`code` 
WHERE
  t1.dept_id = 842 
  OR t1.pay_dept_id = 842 
  AND t1.data_flag = 1 UNION ALL
SELECT
  "对象存储" AS type,
  t1.instance_name AS instanceName,
  t1.instance_id AS instanceId,
  "专有云" AS area,
  "阿里云" AS source,
  ( CASE t1.`status` WHEN 4 THEN '已释放' ELSE '运行中' END ) AS `status`,
  t1.real_produce_time AS openTime,
  t1.releasing_time AS releaseTime,
  t2.allocate_time AS changeTime,
  CONCAT(
    '{',
    CONCAT_WS( ',', CONCAT( '"', 'storage', '":"', t1.storage_capacity, '"' ), CONCAT( '"', 'permissionType', '":"', t1.read_write_permission, '"' ) ),
    '}' 
  ) AS adJson,
  t3.app_Id AS appId,
  t3.`name` AS appName 
FROM
  resource_mgr_oss t1
  LEFT JOIN resource_mgr_dynamic_allocate t2 ON t2.resource_id = t1.id 
  AND t2.resource_type = 3 
  AND t2.id = ( SELECT id FROM resource_mgr_dynamic_allocate WHERE t1.id = t2.resource_id AND t2.resource_type = 1 ORDER BY allocate_time DESC LIMIT 1 )
  LEFT JOIN temp_irs_app_detail t3 ON t1.app_code = t3.`code` 
WHERE
  t1.dept_id = 842 
  OR t1.pay_dept_id = 842 
  AND t1.data_flag = 1
```

#### 排序

##### 字段绝对值排序

```mysql
SELECT
  d.dept_name AS 所属机构,
  u.login_name AS 账号,
  u.real_name AS 姓名,
  u.phone AS 电话,
  ( CASE u.user_type WHEN 0 THEN '门户' ELSE '后台' END ) AS 用户类型,
  ( CASE u.`status` WHEN 0 THEN '正常' WHEN 1 THEN '锁定' ELSE '禁用' END ) AS 状态,
  GROUP_CONCAT(r.role_name) as 角色名称,
  GROUP_CONCAT(a.data_auth_description) as 角色权限描述
  
FROM
  sys_user u
  LEFT JOIN sys_dept d ON u.dept_id = d.dept_id
  LEFT JOIN sys_user_role t ON u.user_id = t.user_id
  LEFT JOIN sys_role r ON r.role_id = t.role_id
  LEFT JOIN sys_role_data_auth s ON s.role_id = r.role_id 
  LEFT JOIN sys_data_auth a ON s.data_auth_id = a.id
  WHERE t.data_flag = 1 and u.data_flag = 1
  GROUP BY u.user_id
```

##### 连接查询最新一条记录

```mysql
SELECT
	* 
FROM
	USERS u
	LEFT JOIN ( SELECT MAX( id ) AS id, userId FROM USER_AUTH GROUP BY userId ) AS ua ON ua.userId = u.id

```

