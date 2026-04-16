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

## 3.多条件、多表联合查询
```sql
SELECT student.*, sc.* 
FROM student,sc                     -- 联合查询两张表中的数据           
WHERE student.Sno = sc.Sno          -- 指定连接条件（这里是双连接）
-- INNER JOIN sc ON s.Sno = sc.Sno  -- 更兼容、实际常用的连接写法
AND student.Sno LIKE "21%"          -- 截取21开头的学号
-- AND LEFT(student.sno,2) = "21"   -- 也可以用字符串截取匹配左边两个字符
AND student.Sdept IN ("计算机", "外国语")   -- s IN (1,2) 与 s=1 or s=2 作用相同
AND sc.Grade BETWEEN 60 AND 90;             -- 也可以写成Grade >= 60 AND Grade <= 60
```

### ★ 指定连接方式：JOIN关键字的使用
```sql
-- 连接操作：在两表的笛卡尔积（排列组合）中选择符合连接条件的一部分元组
-- 悬浮元组：只出现在其中一个表上的属性。

-- 自然连接：舍弃两张表的悬浮元组，并且对两表相同的属性列只保留一个（不会记录R.s和L.s，统一记到s列中）
SELECT * FROM lt 
NATURAL JOIN rt
WHERE "查询条件";

-- 外连接：保留两表的悬浮元组
SELECT lt.*, rt.* 
FROM lt, rt
INNER JOIN rt ON "连接条件"
WHERE "查询条件";

-- 左连接：保留左表的悬浮元组
SELECT lt.*, rt.*
FROM lt, rt
RIGHT JOIN rt ON "连接条件"
WHERE "查询条件";


-- 右连接：保留右表的悬浮元组
SELECT lt.*, rt.*
FROM lt, rt
RIGHT JOIN rt ON "连接条件"
WHERE "查询条件";
```

## 4.聚集函数GROUP、计数函数COUNT()

![](20260414233821743.png)

```sql
-- 查询每个系有多少个同学
select Sdept AS '系别', COUNT(Sno) AS '学生人数' from student GROUP BY Sdept;

系别	学生人数	
-------	-----------
电子工程  3
计算机	  5
外国语	  3
```

## 5.平均值函数AVG()与条件比较

![](20260414234554281.png)

```sql
-- 查询选课门数在两门以上的同学的选课门数及其平均成绩
SELECT Sno AS '学号', COUNT(Cno) AS '选课门数', AVG(Grade) AS ' '
FROM sc
GROUP BY Sno
HAVING COUNT(Cno) > 2;
```

需要注意的是，`WHERE` 是对**原始表**中的每一行进行过滤。它在 `GROUP BY` 之前执行。HAVING 是对**分组后的结果**进行过滤。它在 `GROUP BY`、`COUNT()`、`AVG()` **之后执行**。

## 6. 