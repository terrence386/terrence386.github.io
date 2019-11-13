### 创建表
```
create table table_name (
    id INT(10),
    name varchar(25),
    depid int(25)
)
````

###  查看表
```
show tables;
```
### 设置主键
```
create table table_name (
    id INT(10) primarykey,
    name varchar(25),
    depid int(25)
)
```
或者
```
create table table_name (
    id INT(10),
    name varchar(25),
    depid int(25),
    primarykey(id)
)
```
多字段联合主键
```
create table table_name (
    id INT(10),
    name varchar(25),
    depid int(25),
    primarykey(id,name)
)
```
## 外键约束
增加名为fk_emp_dept1的外键 依赖于tb_dept1的主键id
```
create table table_name (
    id INT(10),
    name varchar(25),
    depId int(25),
    primarykey(id,name),
    CONSTRAINT fk_emp_dept1 FOREIGNKEY(deptId) REFERENCES tb_dept1(id)
)
```
## 非空约束/唯一约束/自增
not null/unique/auto_increment
### 查看表结构
desc table_name;  show create table table_name;




