
----------------------------------------------建库-----------------------------------------------
--1.新建数据库dbstudy
create database dbstudy
on primary
( name='dbstudy',
filename='D:\大学\SQL\SQL自建数据库\第1次\dbstudy.mdf',
size=10mb,
filegrowth=10mb)
log on
(name='dbstudy.log',
filename='D:\大学\SQL\SQL自建数据库\第1次\dbstudy_log.ldf',
size=5mb,
filegrowth=10%
)
--------------------------------------------建表----------------------------------------------
--2.建班级表（班号，班名）-------需要在学生信息表建立之前建立，因为学生信息表中的班号必须与班级表的班号对应
use dbstudy
create table classinfo
(cid int not null primary key identity(1,1),--班级号
cname nvarchar(10)--班名
)
select * from classinfo
--3.建学生信息表（学号，姓名，性别，年龄，系名，班号）-----学号为主键---班号为外键
use dbstudy
create table studentinfo
(sid int not null primary key,--学号
sname nvarchar(10),--姓名
sgender bit,--性别(bit类型只能是1或0)
sage int not null,--年龄
sdept nvarchar(10),--系名
cid  int not null foreign key (cid) references classinfo(cid)--班号

)

select * from studentinfo
--4.建课程表（课号，课名,先修课号，学分）---------先修课号为外键
use dbstudy
create table subjectinfo
(subid int not null primary key,--课号
subname nvarchar(10),--课名
pnoid int not null foreign key (pnoid) references subjectinfo(subid),--先修课号
subcredit int not null--学分
)
select * from subjectinfo
--5.建选课表（学号，课程号，分数）---------学号+课程号为主键，学号为外键，课程号为外键
use dbstudy
create table sc
(sid int not null,--学号
subid int not null ,--课程号
grade int not null,--分数
primary key (sid,subid),
foreign key (sid) references studentinfo(sid),
foreign key (subid) references subjectinfo(subid),
)

select * from sc

---删除
drop table sc
drop table subjectinfo
drop table studentinfo
drop table classinfo
---输出
select * from classinfo
select * from studentinfo
select * from subjectinfo
select * from sc
------------------------------------------填加数据--------------------------------------------
--6.向班级表中添加数据
insert into classinfo
values('计科201'),('计数202'),('数字203')
select * from classinfo
--7.向学生信息表中添加数据
insert into studentinfo
values 
(201,'张山删',0,19,'计科',3),
(202,'吴二',0,20,'计数',2),
(203,'老妖',1,21,'数媒',1)
select * from studentinfo
--8.向课程表中添加数据
insert into subjectinfo
values('11','数据库','11','5'),
('22','C++','33','5'),
('33','C语言','33','5'),
('44','算法设计与分析','66','5'),
('55','机器学习','66','3'),
('66','python','33','4'),
('77','概率论','77','5')
select * from subjectinfo
--9.向选课表中添加数据
insert into sc
values('201','11','90'),
('202','77','80'),
('203','33','60'),
('203','55','70')
select * from sc
-----------------------------------------修改表结构----------------------------------------------
--10.为学生表添加属性电话号码-------修改表结构,添加字段
alter table studentinfo
add Phonenumber nvarchar(11)
select * from studentinfo
--11.为学生表添加属性邮箱-------修改表结构,添加字段
alter table studentinfo
add Email nvarchar(20)
select * from studentinfo
--12.给电话号码赋值-------更新数据,给电话号码赋值
update studentinfo
set Phonenumber='17616145910'
where sid=201
update studentinfo
set Phonenumber='12345678910'
where sid=202
update studentinfo
set Phonenumber='15634528101'
where sid=203
select * from studentinfo
--13. 给邮箱赋值-------更新数据
update studentinfo
set Email='17616145910@qq.com'
where sid=201
update studentinfo
set Email='12345678910@qq.com'
where sid=202
update studentinfo
set Email='15634528101@qq.com'
where sid=203
select * from studentinfo
-----------------------------------------表的简单查询----------------------------------------------
--1.查询dbstudy库中所有的表
select * from sysobjects where xtype='U'


--2. 查询学生表和班级表的数据
select * from classinfo
select * from studentinfo
--3.将学生表中班级号大于等于2的学生性别改为1---更新数据
update studentinfo
set sgender=1
where cid>=2

select * from studentinfo
--4.将所有学生的邮箱改为空---更新数据
update studentinfo
set Email=NULL

select * from studentinfo
--5.将学号大于1080的学生的生日改为1999-03-02----更新数据
alter table studentinfo
add birthday nvarchar(12)

insert into studentinfo
values 
(1080,'张五',1,15,'计科',3,'17616145910','17616145910@qq.com','1888-03-12'),
(1081,'吴四',0,30,'计数',2,'17616145910','17616145910@qq.com','1888-03-12'),
(1082,'老三',1,21,'数媒',1,'17616145910','17616145910@qq.com','1888-03-12')
select * from studentinfo

update studentinfo
set birthday='1999-03-02'
where sid>1080

select * from studentinfo
--6.删除班级为1的学生-----删除数据
drop table sc
delete from studentinfo
where cid=1                    
select *from studentinfo
--7. 给学生表插入多条数据
insert into studentinfo
values 
(1001,'五五',1,15,'计科',3,'17616145910','17616145910@qq.com','1888-03-12'),
(1002,'四四',0,30,'计数',2,'17616145910','17616145910@qq.com','1888-03-12'),
(1003,'三三',1,21,'数媒',1,'15616145910','13616145910@163.com','1888-03-12'),
(1004,'二二',1,15,'计科',3,'17616145910','17616145910@163.com','1888-03-12'),
(1005,'一一',0,30,'计数',2,'15616145910','1561614545910@qq.com','1888-03-12'),
(1006,'七七',1,21,'数媒',1,'17616145910','17616145910@qq.com','1888-03-12'),
(1007,'八八',0,30,'计数',2,'17616145910','17616145910@163.com','1888-03-12'),
(1008,'九九',1,21,'数媒',1,'19616145910','19616145910@163.com','1888-03-12')
select * from studentinfo
--8.给学生表定义别名stu------查询----表的别名
select * from studentinfo as stu
--9. 查询学生表中的姓名和性别,属性名用汉字表示-----查询----列的筛选----列的别名
select sname as 姓名, sgender as 性别
from  studentinfo as stu
--10.查询前10条部分数据-----查询----行的筛选
select top 10 *from studentinfo
--11.查询前10%条数据的姓名和性别
select top 10 percent sname,sgender from studentinfo
--12. 按照学号降序排列-------排序
select *from studentinfo
order by sid  desc
--13. 按照班级升序排列,当班级号相同时按照学号降序排列------排序
select *from studentinfo
order by cid asc,sid  desc
--14.显示所有班级的班级号-------消除重复行
select distinct cid from classinfo
--15.显示学号大于1000小于1005的学生的学号和姓名-----条件筛选where----between   and 的用法
select sid as 学号,sname as 姓名 from studentinfo
where sid between 1000 and 1005
--16.取班级号为1-3的学生信息-----in的用法
select * from studentinfo
where cid in(1,2,3)
--17.取班级号为1或3的学生信息
select * from studentinfo
where cid  in(1,3)
--18.取班级号不在1,3班的学生学号和姓名-------not in的用法
select sid,sname from studentinfo
where cid  not in(1,3)
--19.查询名字中有五字的学生
select * from studentinfo
where sname like '%五%'
--20. 查询名字姓“吴”的学生
select * from studentinfo
where sname like '吴%'
--21.查询名字为两个字,姓九的学生
select * from studentinfo
where sname like '九_'
--22.查询姓名为null的学生
update studentinfo
set sname=NULL
where sid=1002

select * from studentinfo
where sname is null
--23.查询姓名不为空的学生
select * from studentinfo
where sname is not null
--24.查询电话号码为13开头的学生
update studentinfo
set Phonenumber='13616145910'
where sid=1004
select * from studentinfo
where Phonenumber like '13%'
--25.查询电话号码为15,17,19开头的学生
select * from studentinfo
where Phonenumber like '1[5_7_9]%'
--26.查询电话号码不是15,17,19开头的学生
select * from studentinfo
where Phonenumber like '1[^5_7_9]%'
--27.查询电话号码是以15-19开头的学生
select * from studentinfo
where Phonenumber like '1[5-9]%'
--28.查询邮箱是qq邮箱的学生
select * from studentinfo
where Email like '%@qq.com'
--------------------------------------多表、GROUP子句、关键字、联合查询-------------------------------------------
--1. 查询学生的姓名和班级名称
select sname,cname from studentinfo as st
inner join classinfo as cl on cl.cid=st.cid

--2. 查询学号,姓名,课程名,分数-------多表连接
select sc.sid,sname,subname,grade from sc
inner join subjectinfo as sub on sub.subid=sc.subid
inner join studentinfo as st on st.sid=sc.sid

--3. 查询学号,姓名,课程名,分数,按照学号升序排列，学号相同时，按照分数降序排列----多表连接+连接后排序
select sc.sid,sname,subname,grade from sc
inner join subjectinfo as sub on sub.subid=sc.subid
inner join studentinfo as st on st.sid=sc.sid
order by sid asc,grade desc

--4.查询学生学号，姓名，性别，年龄，班名，课名，课程分数-----多表连接
select sc.sid,sname,sgender,sage,cname,subname,grade from studentinfo as st
inner join sc on sc.sid=st.sid
inner join subjectinfo as sub on sub.subid=sc.subid
inner join classinfo as cl on cl.cid=st.cid

---5.按照性别统计人数,只列出人数
select count(*)  as 人数
from studentinfo
group by sgender
---6.按照性别统计人数,列出性别,人数
select sgender,count(*)  as 人数
from studentinfo
group by sgender
---7.按照科目分组,列出科目序号和每科的平均成绩
select sc.subid,  avg(grade)as avg 
from sc
group by sc.subid
---8.显示每个班的男女生人数,列出性别,班号,人数
select sgender,cid,count(*)as number from studentinfo 
group by cid,sgender
---9.统计学号大于2的各班各性别人数,列出班号,性别,人数
select cid,sgender,count(*)as number from studentinfo 
where sid>2
group by cid,sgender

---10.统计学号大于2的各班各性别人数,列出班名,性别，人数
select cl.cname,sgender,count(*)as number from studentinfo as st
inner join classinfo as cl on cl.cid=st.cid
where sid>2
group by cl.cname,sgender

---11.统计学号>2的各班级各性别的学生人数>1的信息,列出班名,性别,人数,并按照人数进行降序排列
select cl.cname,sgender,count(*)as number from studentinfo as st
inner join classinfo as cl on cl.cid=st.cid
where sid>2
group by cl.cname,sgender
having count(*)>1
order by count(*) desc
---12.将cid和stid合并，去掉重复值----cid和stid类型必须一致
select cid from classinfo 
union
select sid from studentinfo
---13. 将cid和stid合并，保留重复值
select cid from classinfo 
union all
select sid from studentinfo
---14. 求cid和stid的交集
select cid from classinfo 
intersect
select sid from studentinfo
---15.求cid-stid
select cid from classinfo 
except
select sid from studentinfo
--16. 查询参加了考试的学生所有信息---用in完成
select * from studentinfo
where sid in 
(select distinct sid from sc)
--17.查询参加了考试的学生所有信息--用exists完成
select * from studentinfo
where  exists
(select * from sc 
where studentinfo.sid=sc.sid)
--18.查询学生信息,按照学号降序排列,并将查询出的记录,重新从1开始编号.
select * , row_number() over (order by sid desc) as num from studentinfo
--19. 查询重新标号数为5-8的记录
select * from 
(select * ,row_number() over (order by sid desc) as num  from studentinfo) as t1
where num between 5 and 8
--20.选择跟五五在一个班学习的学生的信息----用in完成
select * from studentinfo
where cid in 
(select cid from studentinfo
where sname='五五'
)
--21. 查询选修了“数据库”的学生的学号
select sid  from sc 
where subid in 
(select subid from  subjectinfo
where subname= '数据库')
--22.查询选修了“数据库”的学生所有信息

select * from studentinfo
where sid in 
(select sid  from sc 
where subid in 
(select subid from  subjectinfo
where subname=   '数据库')
)
--23.找出每个学生超过他选修课程平均成绩的课程号
select sid ,subid
from sc x
where grade>
(select avg(grade)
 from sc y
 where y.sid =x.sid)
--24 查询没有选修1号课程的学生姓名
 select sname from studentinfo
 where not exists
 (select * from sc
 where studentinfo.sid=sc.sid and subid='1'
 )
 -----------------------------------------实验五----------------------------------
 --1.建采购数据库dbspj,并保存.
create database dbspj
 on primary 
 (name='dbspj',
 filename='D:\大学\SQL\SQL自建数据库\采购数据库\dbspj.mdf',
 size=10mb,
 filegrowth=10mb)
 log on
 (name='dbspj.log',
 filename='D:\大学\SQL\SQL自建数据库\采购数据库\dbspj_log.ldf',
 size=5mb,
 filegrowth=10%)

use dbspj
----1.建表供货商s1,属性有sno,sname,city. 
 create table s
( sno nvarchar(10) primary key,
  sname nvarchar(20),
  scity nvarchar(20),
)
select * from  s
--2.增加如下数据.请举例: 增加一个新的数据,但违反实体完整性,不可增加的例子
insert into s values('S1','精益','天津');
insert into s values('S2','盛锡','北京');
insert into s values('S3','东方红','北京');
insert into s values('S4','丰泰盛','天津');
insert into s values('S5','为民','天津');

select * from s
 ----3.建零件表p,   属性有pno,pname ,color,weight.
 create table P
( pno nvarchar(10) primary key,
  pname nvarchar(20),
  color nvarchar(20),
  weight nvarchar(20),
)
select * from  P
----4,增加下列数据后,请举例: 违反实体完整性而不能增加的例子
insert into P values('P1','螺母','红',12);
insert into P values('P2','螺栓','绿',17);
insert into P values('P3','螺丝刀','蓝',14);
insert into P values('P4','螺丝刀','红',14);
insert into P values('P5','凸轮','蓝',40);
insert into P values('P6','齿轮','红',30);

select * from P

 -----5 ,建客户表J，属性有jno ,jname,city,其中jname要求值唯一,不能重复
create table J
( jno nvarchar(10) primary key ,
  jname nvarchar(20),
  city nvarchar(20),
)
alter table J -----修改表结构
add unique(jname)     -------添加姓名取唯一值的约束

select * from  J


insert into J values('J1','三建','北京');
insert into J values('J2','一汽','长春');
insert into J values('J3','弹簧厂','天津');
insert into J values('J4','造船厂','天津');
insert into J values('J5','机车厂','唐山');
insert into J values('J6','无线电厂','常州');
insert into J values('J7','半导体厂','南京');
insert into J values('J6','半导体厂','南京');

select * from J
----6. 建采购单表spj,属性有sno ,pno,jno,qty(数量）
create table spj
( sno nvarchar(10),
  pno nvarchar(10),
  jno nvarchar(10),
  qty int not null,--供应数量
  primary key(sno,jno),
  foreign key (sno) references S(sno),
  foreign key (pno) references P(pno),
  foreign key (jno) references J(jno)
)
select * from  spj
----7.增加下列数据后,请举例1: 违反参照完整性而无法增加新数据的例子.举例2: 违反实体完整性而无法增加新数据的例子
insert into SPJ values('S1','P1','J1',200);
insert into SPJ values('S1','P1','J3',100);
insert into SPJ values('S1','P1','J4',700);
insert into SPJ values('S1','P2','J2',100);
insert into SPJ values('S2','P3','J1',400);
 insert into SPJ values('S5','P6','J2',200);
insert into SPJ values('S5','P6','J4',500);
select * from SPJ

insert into SPJ values('S10','P1','J1',200);--违反参照完整性：
insert into SPJ values('S5','P6','J4',200);--违反实体完整性：

---8.运行drop table s ,这时候可以删除s吗?
drop table s
--9. 建立表SPJ,属性有sno ,pno,jno,qty(数量）,要求qty在0到100之间
drop table spj

create table SPJ
( sno nvarchar(10),
  pno nvarchar(10),
  jno nvarchar(10),
  qty int not null check([qty]>=0 and [qty]<=100),--供应数量
  primary key(sno,jno),
  foreign key (sno) references S(sno),
  foreign key (pno) references P(pno),
  foreign key (jno) references J(jno)
)
select * from  SPJ
---10.举例：违反用户定义的完整性导致不能增加的例子
insert into SPJ values('S5','P6','J4',700);
--11.建立教师信息表，
create table teacher 
(eno numeric(4) primary key,
ename  char (10),
sal numeric(7,2),
deduct numeric(7,2),
esex char(2),
); 
--修改上述代码，要求每个教师应发工资>=3000，应发工资是工资列和扣除项deduct之和。教师号在1000-9997之间，姓名不能取空值，性别只能是男or女。
drop table Teacher
create table Teacher 
(eno numeric(4) primary key constraint c1 check(eno between 1000 and 9997),
ename  char (10) constraint c2 not null,
sal numeric(7,2),
deduct numeric(7,2),
esex char(2) constraint  c3 check (esex in ('男','女')),
constraint c4 check (sal+deduct >=3000)
); 
select * from Teacher
--12.删除教师信息表中的教师号在1000-9999的限制
alter table Teacher 
drop constraint c1

insert into Teacher 
values(9999,'d',2000,3000,'男')
select * from Teacher

use dbstudy
select * from studentinfo
select * from subjectinfo
select * from sc
select * from classinfo
--13. 创建一个日志表classinfo_log,记录对班级信息表的操作
create table classinfo_log
(
 logid int identity (1,1) primary key,
 opdate datetime default getdate(),
 opuser nvarchar(50),
 opname nvarchar(50)
)

select * from classinfo_log
--14.创建一个触发器tg_class,当对班级信息表进行增加记录时,将修改记录到 classinfo_log中
create trigger tg_class
on classinfo after insert
as
insert into classinfo_log(opuser,opname)
select user_name(),'增' from inserted;
 --15.班级信息表中增加一条记录,查看日志表classinfo_log中记录,验证触发器tg_class是否启动
insert into classinfo
values('计数203')


select * from classinfo_log
--16.创建一个触发器tg2_class,当对班级信息表进行修改数据时,将修改记录到 classinfo_log中
create trigger tg2_class
on classinfo after update
as
insert into classinfo_log(opuser,opname)
select user_name(),'改' from inserted;
--17. 班级信息表中修改一条记录,查看日志表classinfo_log中记录,验证触发器tg2_class是否启动
update classinfo
set cname='数媒201'
where cid=3

select * from classinfo_log

select * from classinfo

drop trigger tg_class
drop trigger tg2_class
drop table classinfo_log
drop table Teacher
drop table SPJ
drop table J
drop table P
drop table s
----------------------------实验四--------------------------------------
use dbstudy
select * from studentinfo
select * from classinfo
select * from sc
select * from subjectinfo
--1. 显示计数202班学生的班级名及学生的所有信息，将该查询定义为一个视图，名为stu_class
create view stu_class
as
select studentinfo.*,classinfo.cname  from studentinfo
inner join classinfo
on classinfo.cid=studentinfo.cid
where cname='计数202'

select * from stu_class

--2. 修改视图stu_class,为查询计科201班学生的班级名及学生的所有信息
alter view stu_class
as 
select studentinfo.*,classinfo.cname  from studentinfo
inner join classinfo
on classinfo.cid=studentinfo.cid
where cname='计科201'

select * from stu_class

--3.删除视图stu_class
drop view stu_class
--4. 建立1班学生的视图
create view stu_1
as
select * from studentinfo
where cid=1

select * from stu_1

--5. 建立2班学生的视图,并要求进行修改和插入时仍需保证此视图内只有2班的学生
create view stu_2
as
select * from studentinfo
where cid=2
with check option

select * from stu_2

--6.定义一个反映学生出生年份,姓名的视图---可以添加视图的列名
create view stu_3(sname,sbirth)
as
select sname,2022-sage as 出生年份
from studentinfo

select * from stu_3

--7. 将学生的学号和平均成绩定义为一个视图
create view stu_avg(sid,savg)
as 
select sid, avg(grade)as 平均分
from sc
group by sid

select * from  stu_avg

--8.建立登录账号A，密码为123
create login A with password='123'
--9.建立用户A，赋予A对数据库dbstudy 的studentinfo表和classinfo表的select权限
use dbstudy
create user A
grant select on studentinfo
to A
grant select on classinfo
to A
--10.收回用户A对classinfo表的select权限
revoke select on classinfo to A
--11.建立视图，可以查询11号课程的学生号、成绩和学生名。--并赋予用户A对该视图的查询权限。
create view stu_4
as
select sc.sid,sc.grade,studentinfo.sname from sc
inner join studentinfo on studentinfo.sid = sc.sid
where subid = 11

select * from stu_4
grant select on stu_4 to A

--12.建立登录账号B，密码为456
create login B with password='456'
--13. 建立用户B，赋予用户B对dbstudy中的scinfo表的查询权限。
use dbstudy
create user B
grant select on sc
to B
--删
drop user B
drop view stu_4
drop user A
drop view stu_avg
drop view stu_3
drop view stu_2
drop view stu_1
----------------------------基本T-SQL语句——————实验六——————————
--1.输出1-10间的偶数
declare @num int----定义变量
set @num=1-----赋值
while @num<11
begin---------大括号开始
if @num%2=0
begin 
print @num----输出
end
set @num+=1 
end--------------大括号结束
--2.输出1-10的和
declare @sum int 
set @sum=0
declare @n int
set @n=1
while @n<11
begin
   set @sum=@sum+@n
   set @n=@n+1
end
print @sum
--3.捕获异常
--预删除班级表，删除前输出‘删除班级表中。。。’，删除成功，输出‘已经删除’。
--如果不能删除，请输出‘不能删除’
use dbstudy

begin try ------如果有的代码可能不能正常执行，会出现异常，可以放在try块中
  print '删除班级表中。。。'------正常执行的语句
  drop  table  classinfo------出现异常，不能正常执行
  print'已经删除'   ----前一句出现异常，所以直接跳到catch块中，则该句没有被执行
end try

begin catch------捕获异常，只有出现异常，才会运行catch块中的代码
   print '不能删除'
end catch 
--4.等待3秒后显示所有年龄>20的学生姓名
waitfor delay '00:00:03'
select * from studentinfo
where sage>20
--5.创建一个触发器t1,当对学生表中删除某一个学生后,将sc表中相关数据删除
create trigger t1 on   studentinfo
instead of delete
as
declare @studentID int
select @studentID=sid
from Deleted
delete from sc where sc.sid=@studentID
go
--6.删除学生表中一条记录,通过查看表sc中相关记录是否删除,验证触发器t1是否启动
delete from studentinfo 
where sid=2

-------------------------------存储过程-------------------------
use dbstudy
select * from studentinfo 
select * from sc
----1.创建一个存储过程p4,显示该学生的所有信息,p4带有一个参数,用于接受学号
create procedure p4   @a int           -------------------@a为参数，参数类型为int
as
select * from studentinfo  
where sid=@a
----2.执行存储过程p4,查找学号为203的学生所有信息
exec p4 203                             ---------------将203传给@a
 
----3.创建存储过程,计算指定学号学生的平均成绩
create proc p8 @studentID int
as
select AVG(grade) as 平均成绩 from sc 
where sid=@studentID
go

-----4.执行上述存储过程，计算学号为203的学生的平均成绩
exec p8  203

--5。在示例数据库的学生基本信息表上如果存在出生时间在1995年以前的学生，给出这些学生的列表。
---否则给出一条提示信息，说明没有满足条件的学生；
use dbstudy

if exists(select * from studentinfo
          where sage>21  
          )
begin  
  select * from studentinfo
  where sage>21
  end
 else 
  print'no' 
--6显示所有系别为‘计科’的学生信息，并且在显示之前，暂停1分钟；
waitfor delay '00:00:04'
select * from studentinfo
where sdept='计科'
--7。创建一个函数,可以按学号查询学生选修课的平均成绩，
--如果不及格，显示其学号，姓名，并输出‘该同学平均成绩不及格’，否则输出 "全部通过"
create procedure p19 @a int 
as
 if exists(select AVG(grade) from studentinfo
     inner join sc on sc.sid=studentinfo.sid
     where studentinfo.sid=@a
     group by studentinfo.sid
     having AVG(grade)<60 )
 begin 
   print  '该同学平均成绩不及格'
 end
else
    print   '全部通过'
 

 ---select * from sc
---update sc
--set grade=30
--where stid=6

 
  exec p19 203

--8。创建一个触发器，当对学生表执行UPDARE操作时，该触发器被触发，不允许修改学生表中的姓名；
create trigger t100 on studentinfo for update
as
if (UPDATE(sname))
begin
print'不能修改学生表中的姓名'
rollback  transaction
end

else
print'修改成功'

update  studentinfo 
set sname=122

select  *  from studentinfo
--9创建一个存储过程，它带有一个输入参数，用于接受学号，显示该学生的姓名、选修课的课程名、成绩
create procedure p98 @a int 
as
 select sname,subname,grade from studentinfo
 inner join sc on studentinfo.sid=sc.sid
 inner join subjectinfo on sc.subid=subjectinfo.subid
 where studentinfo.sid=@a 

select * from sc
exec p98 203

--10。创建一个存储过程，它带有一个输入参数，用于接受学号和分数，显示该学生的姓名、选修课的课程名、成绩。
create procedure p901 @a int ,@b int
as
 select sname,subname,grade from studentinfo
 inner join sc on studentinfo.sid=sc.sid
 inner join subjectinfo on sc.subid=subjectinfo.subid
 where studentinfo.sid=@a and grade=@b


select * from sc
exec p901 203,70

---------------------------------事务--------------------------
--11.事务
--先更改班级表中的cid为2的记录的cname为数字媒体,再删除班级表,
--如果不能删除,则cid为2的记录也不做修改
use dbstudy
select * from classinfo
begin try 
 begin tran----------开始事务
 update  classinfo 
 set cname='shumei'
 where cid=2

  drop  table  classinfo
 commit tran------------提交事务
end try

 begin catch
   print('修改失败')
   rollback tran------------回滚事务
 end catch
--12.事务
 --先修改cid为2的记录的cname为3,修改cid为2的记录的cname为4,
 --修改cid为2的记录的cname为5.定义变量@num并赋值,如果@num<2均执行,否则回滚,都不修改
 select * from classinfo
declare @num int
set @num=1
 begin tran---------------开始事务

 update  classinfo 
 set cname='3'
 where cid=2
 update  classinfo 
 set cname='4'
 where cid=3
 update  classinfo 
 set cname='5'
 where cid=4

 if @num<2
     commit tran-------提交事务
 else 
     rollback tran-------回滚事务
--13.事务练习：
--（1）建立一张bank表，属性有顾客ID，顾客姓名，顾客余额。
use dbstudy
create table bank
(
id int primary key identity(1000,1),
name nvarchar(20) not null,
money money
)

drop table bank
select * from  bank
--（2）添加bank表约束，要求顾客余额>=1.
alter table bank 
add constraint check_currentMoney check(money>=1)
--（3）向表中添加两条数据。
insert into bank 
values('张三',1000)
insert into bank 
values('李四',1)

select * from bank

--（4）从顾客1中转账至顾客2.（用到事务）
begin transaction
declare @error1 int,@error2 int
set @error1=0
set @error2=0
update bank 
set money=money-1000
where name='张三'
set @error1=@@ERROR
update bank 
set money=money+1000
where name='李四'
set @error2=@@ERROR

if(@error1=0 and @error2=0)
begin
print '转账成功'
commit transaction
end
else
begin
print '转账失败'
rollback transaction
end

--14.事务练习
--（1）建立班级表（班号，班名，人数）
use dbstudy
create table classinfo1
(cno int primary key,
 cname nvarchar(20),
 cnumber int check (cnumber>=0)
 )
--（2）向班级表中插入3条数据。
insert into classinfo1
values(1,'计数1',0),
   (2,'计数2',0),
   (3,'计数3',0)

select * from classinfo1
--（3）建立学生表（学号，姓名，班号），注意外码
create table studentinfo1
( sno int primary key,
sname nvarchar(20),
 cno int,
 foreign key (cno) references classinfo1(cno)
 )
--（4）向学生表中添加一条记录，并修改班级表中对应的人数值。（用到事务）
begin try 
   begin tran
    insert into studentinfo1 
	values (12,'张三',4)
	update classinfo1
	set cnumber=cnumber+1
	where cno=4
	commit tran
end try
begin catch
	  print '无法执行1'
	  rollback tran
end catch

select * from studentinfo1
select * from classinfo1
---------------------
declare @e1 int ,@e2 int
begin tran
    insert into studentinfo1 values (13,'张三',3)
	set @e1=@@ERROR 
    update classinfo1
	 set cnumber=cnumber+1
	 where cno=3
	 set @e2=@@ERROR 
	 if (@e1=0  and @e2=0)
	    commit tran
	else 
	   begin
	   print '无法执行2'
	    rollback tran 
		end
select * from studentinfo1
select * from classinfo1





--------------------------快速备份--------------------------
---1. 将班级表中的所有信息存入到一个不存在的表test1中
select  * into test1 from  classinfo

select * from test1

--2.将学生的表结构存入表test5中，数据不复制
select  * into test5 from studentinfo
where 1=2                   -------选一个值为假的表达式即可

select * from test5

---3.将学生表中的学生姓名和性别复制到已经存在的表test5中--学生表中stid是自动赋值的，若不是自动赋值，会报错

insert into test5(sname,sgender)
select sname,sgender from studentinfo

select * from test5

--班级的表结构存入表test5中，数据不复制，再把班名复制到已经存在的表test6中--班级表中cid是自动赋值的，若不是自动赋值，会报错
select  * into test6 from classinfo
where 1=2                   -------选一个值为假的表达式即可


insert into test6(cname)
select cname from classinfo

select * from test6
-------------------------------索引------------------------
--1.在studentinfo 中按照学号和姓名分别建立索引
create index in1 on studentinfo(sid)
create index in2 on studentinfo(sname)

--2.使用索引查找姓张的学生的学生信息
select * from studentinfo
with(index(in2))
where sname like'张%'
