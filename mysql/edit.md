# 修改表
##### 修改表名
```
alter table old_table_name rename new_table_name;
```
##### 修改字段数据类型
```
alter table table_name modify field_name dataType;
```
##### 修改字段名
```
alter table table_name change old_field_name new_field_name new_dataType;
```
##### 添加字段
```
alter table table_name add new_field_name dataType first|after old_field_name;
```
##### 删除字段
```
alter table table_name drop field_name;
```
##### 修改字段位置
```
alter table table_name modify field_name1 first|after field_name2;
```
##### 修改表引擎
```
alter table table_name engine=engine_name;
```
##### 删除外键约束
```
alter table table_name drop foreign key foreignkey_name;
```
##### 删除表
```
drop table if exists table_name;
```
