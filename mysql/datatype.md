# 数据类型
##### 整数类型
tinyint  smallint mediumint int bigint
##### 浮点类型 定点数类型
- float     单精度      4字节
- double    双精度      8字节
- decimal   严格定点    M+2字节
##### 日期 时间 类型 

|类型名称|日期格式|日期范围|存储需求|
|---|:--:|---:|---:|
year|YYYY|1901-2155|1字节|
time|hh mm ss|-838-838.59.59|3字节|
date|yyyy--mm-dd|1000-01-01-0000-12-3|3字节|
datetime|yyyy-mm-dd hhmmss|---|8字节|
timestamp|yyyy-mm-dd hhmmss|----|4字节|

##### 字符串类型
