---

---
--- 

# 一、SELECT相关

## 1.指定字段别名
```sql
SELECT Tno 教工号, Tname 姓名, Tpay 工资, Tpay * 0.95 [预发95%的工资] FROM Teacher;
-- 在字段后添加别名，可以指定导出表的表头；如果别名包含特数字或殊字符，需要使用[]包括起来。
```

## 2.查询的去重与排序
```sql
SELECT DISTINCT Tdept 系名 FROM teacher ORDER BY Tdept;
-- DISTINCT 关键字用于去重
-- ORDER BY 关键字用于排序，默认升序（1-9，a-z）
```

## 3.多条件查询
```sql

```