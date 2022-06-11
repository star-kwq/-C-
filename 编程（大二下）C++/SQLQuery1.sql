
----------------------------------------------����-----------------------------------------------
--1.�½����ݿ�dbstudy
create database dbstudy
on primary
( name='dbstudy',
filename='D:\��ѧ\SQL\SQL�Խ����ݿ�\��1��\dbstudy.mdf',
size=10mb,
filegrowth=10mb)
log on
(name='dbstudy.log',
filename='D:\��ѧ\SQL\SQL�Խ����ݿ�\��1��\dbstudy_log.ldf',
size=5mb,
filegrowth=10%
)
--------------------------------------------����----------------------------------------------
--2.���༶����ţ�������-------��Ҫ��ѧ����Ϣ����֮ǰ��������Ϊѧ����Ϣ���еİ�ű�����༶��İ�Ŷ�Ӧ
use dbstudy
create table classinfo
(cid int not null primary key identity(1,1),--�༶��
cname nvarchar(10)--����
)
select * from classinfo
--3.��ѧ����Ϣ��ѧ�ţ��������Ա����䣬ϵ������ţ�-----ѧ��Ϊ����---���Ϊ���
use dbstudy
create table studentinfo
(sid int not null primary key,--ѧ��
sname nvarchar(10),--����
sgender bit,--�Ա�(bit����ֻ����1��0)
sage int not null,--����
sdept nvarchar(10),--ϵ��
cid  int not null foreign key (cid) references classinfo(cid)--���

)

select * from studentinfo
--4.���γ̱��κţ�����,���޿κţ�ѧ�֣�---------���޿κ�Ϊ���
use dbstudy
create table subjectinfo
(subid int not null primary key,--�κ�
subname nvarchar(10),--����
pnoid int not null foreign key (pnoid) references subjectinfo(subid),--���޿κ�
subcredit int not null--ѧ��
)
select * from subjectinfo
--5.��ѡ�α�ѧ�ţ��γ̺ţ�������---------ѧ��+�γ̺�Ϊ������ѧ��Ϊ������γ̺�Ϊ���
use dbstudy
create table sc
(sid int not null,--ѧ��
subid int not null ,--�γ̺�
grade int not null,--����
primary key (sid,subid),
foreign key (sid) references studentinfo(sid),
foreign key (subid) references subjectinfo(subid),
)

select * from sc

---ɾ��
drop table sc
drop table subjectinfo
drop table studentinfo
drop table classinfo
---���
select * from classinfo
select * from studentinfo
select * from subjectinfo
select * from sc
------------------------------------------�������--------------------------------------------
--6.��༶�����������
insert into classinfo
values('�ƿ�201'),('����202'),('����203')
select * from classinfo
--7.��ѧ����Ϣ�����������
insert into studentinfo
values 
(201,'��ɽɾ',0,19,'�ƿ�',3),
(202,'���',0,20,'����',2),
(203,'����',1,21,'��ý',1)
select * from studentinfo
--8.��γ̱����������
insert into subjectinfo
values('11','���ݿ�','11','5'),
('22','C++','33','5'),
('33','C����','33','5'),
('44','�㷨��������','66','5'),
('55','����ѧϰ','66','3'),
('66','python','33','4'),
('77','������','77','5')
select * from subjectinfo
--9.��ѡ�α����������
insert into sc
values('201','11','90'),
('202','77','80'),
('203','33','60'),
('203','55','70')
select * from sc
-----------------------------------------�޸ı�ṹ----------------------------------------------
--10.Ϊѧ����������Ե绰����-------�޸ı�ṹ,����ֶ�
alter table studentinfo
add Phonenumber nvarchar(11)
select * from studentinfo
--11.Ϊѧ���������������-------�޸ı�ṹ,����ֶ�
alter table studentinfo
add Email nvarchar(20)
select * from studentinfo
--12.���绰���븳ֵ-------��������,���绰���븳ֵ
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
--13. �����丳ֵ-------��������
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
-----------------------------------------��ļ򵥲�ѯ----------------------------------------------
--1.��ѯdbstudy�������еı�
select * from sysobjects where xtype='U'


--2. ��ѯѧ����Ͱ༶�������
select * from classinfo
select * from studentinfo
--3.��ѧ�����а༶�Ŵ��ڵ���2��ѧ���Ա��Ϊ1---��������
update studentinfo
set sgender=1
where cid>=2

select * from studentinfo
--4.������ѧ���������Ϊ��---��������
update studentinfo
set Email=NULL

select * from studentinfo
--5.��ѧ�Ŵ���1080��ѧ�������ո�Ϊ1999-03-02----��������
alter table studentinfo
add birthday nvarchar(12)

insert into studentinfo
values 
(1080,'����',1,15,'�ƿ�',3,'17616145910','17616145910@qq.com','1888-03-12'),
(1081,'����',0,30,'����',2,'17616145910','17616145910@qq.com','1888-03-12'),
(1082,'����',1,21,'��ý',1,'17616145910','17616145910@qq.com','1888-03-12')
select * from studentinfo

update studentinfo
set birthday='1999-03-02'
where sid>1080

select * from studentinfo
--6.ɾ���༶Ϊ1��ѧ��-----ɾ������
drop table sc
delete from studentinfo
where cid=1                    
select *from studentinfo
--7. ��ѧ��������������
insert into studentinfo
values 
(1001,'����',1,15,'�ƿ�',3,'17616145910','17616145910@qq.com','1888-03-12'),
(1002,'����',0,30,'����',2,'17616145910','17616145910@qq.com','1888-03-12'),
(1003,'����',1,21,'��ý',1,'15616145910','13616145910@163.com','1888-03-12'),
(1004,'����',1,15,'�ƿ�',3,'17616145910','17616145910@163.com','1888-03-12'),
(1005,'һһ',0,30,'����',2,'15616145910','1561614545910@qq.com','1888-03-12'),
(1006,'����',1,21,'��ý',1,'17616145910','17616145910@qq.com','1888-03-12'),
(1007,'�˰�',0,30,'����',2,'17616145910','17616145910@163.com','1888-03-12'),
(1008,'�ž�',1,21,'��ý',1,'19616145910','19616145910@163.com','1888-03-12')
select * from studentinfo
--8.��ѧ���������stu------��ѯ----��ı���
select * from studentinfo as stu
--9. ��ѯѧ�����е��������Ա�,�������ú��ֱ�ʾ-----��ѯ----�е�ɸѡ----�еı���
select sname as ����, sgender as �Ա�
from  studentinfo as stu
--10.��ѯǰ10����������-----��ѯ----�е�ɸѡ
select top 10 *from studentinfo
--11.��ѯǰ10%�����ݵ��������Ա�
select top 10 percent sname,sgender from studentinfo
--12. ����ѧ�Ž�������-------����
select *from studentinfo
order by sid  desc
--13. ���հ༶��������,���༶����ͬʱ����ѧ�Ž�������------����
select *from studentinfo
order by cid asc,sid  desc
--14.��ʾ���а༶�İ༶��-------�����ظ���
select distinct cid from classinfo
--15.��ʾѧ�Ŵ���1000С��1005��ѧ����ѧ�ź�����-----����ɸѡwhere----between   and ���÷�
select sid as ѧ��,sname as ���� from studentinfo
where sid between 1000 and 1005
--16.ȡ�༶��Ϊ1-3��ѧ����Ϣ-----in���÷�
select * from studentinfo
where cid in(1,2,3)
--17.ȡ�༶��Ϊ1��3��ѧ����Ϣ
select * from studentinfo
where cid  in(1,3)
--18.ȡ�༶�Ų���1,3���ѧ��ѧ�ź�����-------not in���÷�
select sid,sname from studentinfo
where cid  not in(1,3)
--19.��ѯ�����������ֵ�ѧ��
select * from studentinfo
where sname like '%��%'
--20. ��ѯ�����ա��⡱��ѧ��
select * from studentinfo
where sname like '��%'
--21.��ѯ����Ϊ������,�վŵ�ѧ��
select * from studentinfo
where sname like '��_'
--22.��ѯ����Ϊnull��ѧ��
update studentinfo
set sname=NULL
where sid=1002

select * from studentinfo
where sname is null
--23.��ѯ������Ϊ�յ�ѧ��
select * from studentinfo
where sname is not null
--24.��ѯ�绰����Ϊ13��ͷ��ѧ��
update studentinfo
set Phonenumber='13616145910'
where sid=1004
select * from studentinfo
where Phonenumber like '13%'
--25.��ѯ�绰����Ϊ15,17,19��ͷ��ѧ��
select * from studentinfo
where Phonenumber like '1[5_7_9]%'
--26.��ѯ�绰���벻��15,17,19��ͷ��ѧ��
select * from studentinfo
where Phonenumber like '1[^5_7_9]%'
--27.��ѯ�绰��������15-19��ͷ��ѧ��
select * from studentinfo
where Phonenumber like '1[5-9]%'
--28.��ѯ������qq�����ѧ��
select * from studentinfo
where Email like '%@qq.com'
--------------------------------------���GROUP�Ӿ䡢�ؼ��֡����ϲ�ѯ-------------------------------------------
--1. ��ѯѧ���������Ͱ༶����
select sname,cname from studentinfo as st
inner join classinfo as cl on cl.cid=st.cid

--2. ��ѯѧ��,����,�γ���,����-------�������
select sc.sid,sname,subname,grade from sc
inner join subjectinfo as sub on sub.subid=sc.subid
inner join studentinfo as st on st.sid=sc.sid

--3. ��ѯѧ��,����,�γ���,����,����ѧ���������У�ѧ����ͬʱ�����շ�����������----�������+���Ӻ�����
select sc.sid,sname,subname,grade from sc
inner join subjectinfo as sub on sub.subid=sc.subid
inner join studentinfo as st on st.sid=sc.sid
order by sid asc,grade desc

--4.��ѯѧ��ѧ�ţ��������Ա����䣬�������������γ̷���-----�������
select sc.sid,sname,sgender,sage,cname,subname,grade from studentinfo as st
inner join sc on sc.sid=st.sid
inner join subjectinfo as sub on sub.subid=sc.subid
inner join classinfo as cl on cl.cid=st.cid

---5.�����Ա�ͳ������,ֻ�г�����
select count(*)  as ����
from studentinfo
group by sgender
---6.�����Ա�ͳ������,�г��Ա�,����
select sgender,count(*)  as ����
from studentinfo
group by sgender
---7.���տ�Ŀ����,�г���Ŀ��ź�ÿ�Ƶ�ƽ���ɼ�
select sc.subid,  avg(grade)as avg 
from sc
group by sc.subid
---8.��ʾÿ�������Ů������,�г��Ա�,���,����
select sgender,cid,count(*)as number from studentinfo 
group by cid,sgender
---9.ͳ��ѧ�Ŵ���2�ĸ�����Ա�����,�г����,�Ա�,����
select cid,sgender,count(*)as number from studentinfo 
where sid>2
group by cid,sgender

---10.ͳ��ѧ�Ŵ���2�ĸ�����Ա�����,�г�����,�Ա�����
select cl.cname,sgender,count(*)as number from studentinfo as st
inner join classinfo as cl on cl.cid=st.cid
where sid>2
group by cl.cname,sgender

---11.ͳ��ѧ��>2�ĸ��༶���Ա��ѧ������>1����Ϣ,�г�����,�Ա�,����,�������������н�������
select cl.cname,sgender,count(*)as number from studentinfo as st
inner join classinfo as cl on cl.cid=st.cid
where sid>2
group by cl.cname,sgender
having count(*)>1
order by count(*) desc
---12.��cid��stid�ϲ���ȥ���ظ�ֵ----cid��stid���ͱ���һ��
select cid from classinfo 
union
select sid from studentinfo
---13. ��cid��stid�ϲ��������ظ�ֵ
select cid from classinfo 
union all
select sid from studentinfo
---14. ��cid��stid�Ľ���
select cid from classinfo 
intersect
select sid from studentinfo
---15.��cid-stid
select cid from classinfo 
except
select sid from studentinfo
--16. ��ѯ�μ��˿��Ե�ѧ��������Ϣ---��in���
select * from studentinfo
where sid in 
(select distinct sid from sc)
--17.��ѯ�μ��˿��Ե�ѧ��������Ϣ--��exists���
select * from studentinfo
where  exists
(select * from sc 
where studentinfo.sid=sc.sid)
--18.��ѯѧ����Ϣ,����ѧ�Ž�������,������ѯ���ļ�¼,���´�1��ʼ���.
select * , row_number() over (order by sid desc) as num from studentinfo
--19. ��ѯ���±����Ϊ5-8�ļ�¼
select * from 
(select * ,row_number() over (order by sid desc) as num  from studentinfo) as t1
where num between 5 and 8
--20.ѡ���������һ����ѧϰ��ѧ������Ϣ----��in���
select * from studentinfo
where cid in 
(select cid from studentinfo
where sname='����'
)
--21. ��ѯѡ���ˡ����ݿ⡱��ѧ����ѧ��
select sid  from sc 
where subid in 
(select subid from  subjectinfo
where subname= '���ݿ�')
--22.��ѯѡ���ˡ����ݿ⡱��ѧ��������Ϣ

select * from studentinfo
where sid in 
(select sid  from sc 
where subid in 
(select subid from  subjectinfo
where subname=   '���ݿ�')
)
--23.�ҳ�ÿ��ѧ��������ѡ�޿γ�ƽ���ɼ��Ŀγ̺�
select sid ,subid
from sc x
where grade>
(select avg(grade)
 from sc y
 where y.sid =x.sid)
--24 ��ѯû��ѡ��1�ſγ̵�ѧ������
 select sname from studentinfo
 where not exists
 (select * from sc
 where studentinfo.sid=sc.sid and subid='1'
 )
 -----------------------------------------ʵ����----------------------------------
 --1.���ɹ����ݿ�dbspj,������.
create database dbspj
 on primary 
 (name='dbspj',
 filename='D:\��ѧ\SQL\SQL�Խ����ݿ�\�ɹ����ݿ�\dbspj.mdf',
 size=10mb,
 filegrowth=10mb)
 log on
 (name='dbspj.log',
 filename='D:\��ѧ\SQL\SQL�Խ����ݿ�\�ɹ����ݿ�\dbspj_log.ldf',
 size=5mb,
 filegrowth=10%)

use dbspj
----1.��������s1,������sno,sname,city. 
 create table s
( sno nvarchar(10) primary key,
  sname nvarchar(20),
  scity nvarchar(20),
)
select * from  s
--2.������������.�����: ����һ���µ�����,��Υ��ʵ��������,�������ӵ�����
insert into s values('S1','����','���');
insert into s values('S2','ʢ��','����');
insert into s values('S3','������','����');
insert into s values('S4','��̩ʢ','���');
insert into s values('S5','Ϊ��','���');

select * from s
 ----3.�������p,   ������pno,pname ,color,weight.
 create table P
( pno nvarchar(10) primary key,
  pname nvarchar(20),
  color nvarchar(20),
  weight nvarchar(20),
)
select * from  P
----4,�����������ݺ�,�����: Υ��ʵ�������Զ��������ӵ�����
insert into P values('P1','��ĸ','��',12);
insert into P values('P2','��˨','��',17);
insert into P values('P3','��˿��','��',14);
insert into P values('P4','��˿��','��',14);
insert into P values('P5','͹��','��',40);
insert into P values('P6','����','��',30);

select * from P

 -----5 ,���ͻ���J��������jno ,jname,city,����jnameҪ��ֵΨһ,�����ظ�
create table J
( jno nvarchar(10) primary key ,
  jname nvarchar(20),
  city nvarchar(20),
)
alter table J -----�޸ı�ṹ
add unique(jname)     -------�������ȡΨһֵ��Լ��

select * from  J


insert into J values('J1','����','����');
insert into J values('J2','һ��','����');
insert into J values('J3','���ɳ�','���');
insert into J values('J4','�촬��','���');
insert into J values('J5','������','��ɽ');
insert into J values('J6','���ߵ糧','����');
insert into J values('J7','�뵼�峧','�Ͼ�');
insert into J values('J6','�뵼�峧','�Ͼ�');

select * from J
----6. ���ɹ�����spj,������sno ,pno,jno,qty(������
create table spj
( sno nvarchar(10),
  pno nvarchar(10),
  jno nvarchar(10),
  qty int not null,--��Ӧ����
  primary key(sno,jno),
  foreign key (sno) references S(sno),
  foreign key (pno) references P(pno),
  foreign key (jno) references J(jno)
)
select * from  spj
----7.�����������ݺ�,�����1: Υ�����������Զ��޷����������ݵ�����.����2: Υ��ʵ�������Զ��޷����������ݵ�����
insert into SPJ values('S1','P1','J1',200);
insert into SPJ values('S1','P1','J3',100);
insert into SPJ values('S1','P1','J4',700);
insert into SPJ values('S1','P2','J2',100);
insert into SPJ values('S2','P3','J1',400);
 insert into SPJ values('S5','P6','J2',200);
insert into SPJ values('S5','P6','J4',500);
select * from SPJ

insert into SPJ values('S10','P1','J1',200);--Υ�����������ԣ�
insert into SPJ values('S5','P6','J4',200);--Υ��ʵ�������ԣ�

---8.����drop table s ,��ʱ�����ɾ��s��?
drop table s
--9. ������SPJ,������sno ,pno,jno,qty(������,Ҫ��qty��0��100֮��
drop table spj

create table SPJ
( sno nvarchar(10),
  pno nvarchar(10),
  jno nvarchar(10),
  qty int not null check([qty]>=0 and [qty]<=100),--��Ӧ����
  primary key(sno,jno),
  foreign key (sno) references S(sno),
  foreign key (pno) references P(pno),
  foreign key (jno) references J(jno)
)
select * from  SPJ
---10.������Υ���û�����������Ե��²������ӵ�����
insert into SPJ values('S5','P6','J4',700);
--11.������ʦ��Ϣ��
create table teacher 
(eno numeric(4) primary key,
ename  char (10),
sal numeric(7,2),
deduct numeric(7,2),
esex char(2),
); 
--�޸��������룬Ҫ��ÿ����ʦӦ������>=3000��Ӧ�������ǹ����кͿ۳���deduct֮�͡���ʦ����1000-9997֮�䣬��������ȡ��ֵ���Ա�ֻ������orŮ��
drop table Teacher
create table Teacher 
(eno numeric(4) primary key constraint c1 check(eno between 1000 and 9997),
ename  char (10) constraint c2 not null,
sal numeric(7,2),
deduct numeric(7,2),
esex char(2) constraint  c3 check (esex in ('��','Ů')),
constraint c4 check (sal+deduct >=3000)
); 
select * from Teacher
--12.ɾ����ʦ��Ϣ���еĽ�ʦ����1000-9999������
alter table Teacher 
drop constraint c1

insert into Teacher 
values(9999,'d',2000,3000,'��')
select * from Teacher

use dbstudy
select * from studentinfo
select * from subjectinfo
select * from sc
select * from classinfo
--13. ����һ����־��classinfo_log,��¼�԰༶��Ϣ��Ĳ���
create table classinfo_log
(
 logid int identity (1,1) primary key,
 opdate datetime default getdate(),
 opuser nvarchar(50),
 opname nvarchar(50)
)

select * from classinfo_log
--14.����һ��������tg_class,���԰༶��Ϣ��������Ӽ�¼ʱ,���޸ļ�¼�� classinfo_log��
create trigger tg_class
on classinfo after insert
as
insert into classinfo_log(opuser,opname)
select user_name(),'��' from inserted;
 --15.�༶��Ϣ��������һ����¼,�鿴��־��classinfo_log�м�¼,��֤������tg_class�Ƿ�����
insert into classinfo
values('����203')


select * from classinfo_log
--16.����һ��������tg2_class,���԰༶��Ϣ������޸�����ʱ,���޸ļ�¼�� classinfo_log��
create trigger tg2_class
on classinfo after update
as
insert into classinfo_log(opuser,opname)
select user_name(),'��' from inserted;
--17. �༶��Ϣ�����޸�һ����¼,�鿴��־��classinfo_log�м�¼,��֤������tg2_class�Ƿ�����
update classinfo
set cname='��ý201'
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
----------------------------ʵ����--------------------------------------
use dbstudy
select * from studentinfo
select * from classinfo
select * from sc
select * from subjectinfo
--1. ��ʾ����202��ѧ���İ༶����ѧ����������Ϣ�����ò�ѯ����Ϊһ����ͼ����Ϊstu_class
create view stu_class
as
select studentinfo.*,classinfo.cname  from studentinfo
inner join classinfo
on classinfo.cid=studentinfo.cid
where cname='����202'

select * from stu_class

--2. �޸���ͼstu_class,Ϊ��ѯ�ƿ�201��ѧ���İ༶����ѧ����������Ϣ
alter view stu_class
as 
select studentinfo.*,classinfo.cname  from studentinfo
inner join classinfo
on classinfo.cid=studentinfo.cid
where cname='�ƿ�201'

select * from stu_class

--3.ɾ����ͼstu_class
drop view stu_class
--4. ����1��ѧ������ͼ
create view stu_1
as
select * from studentinfo
where cid=1

select * from stu_1

--5. ����2��ѧ������ͼ,��Ҫ������޸ĺͲ���ʱ���豣֤����ͼ��ֻ��2���ѧ��
create view stu_2
as
select * from studentinfo
where cid=2
with check option

select * from stu_2

--6.����һ����ӳѧ���������,��������ͼ---���������ͼ������
create view stu_3(sname,sbirth)
as
select sname,2022-sage as �������
from studentinfo

select * from stu_3

--7. ��ѧ����ѧ�ź�ƽ���ɼ�����Ϊһ����ͼ
create view stu_avg(sid,savg)
as 
select sid, avg(grade)as ƽ����
from sc
group by sid

select * from  stu_avg

--8.������¼�˺�A������Ϊ123
create login A with password='123'
--9.�����û�A������A�����ݿ�dbstudy ��studentinfo���classinfo���selectȨ��
use dbstudy
create user A
grant select on studentinfo
to A
grant select on classinfo
to A
--10.�ջ��û�A��classinfo���selectȨ��
revoke select on classinfo to A
--11.������ͼ�����Բ�ѯ11�ſγ̵�ѧ���š��ɼ���ѧ������--�������û�A�Ը���ͼ�Ĳ�ѯȨ�ޡ�
create view stu_4
as
select sc.sid,sc.grade,studentinfo.sname from sc
inner join studentinfo on studentinfo.sid = sc.sid
where subid = 11

select * from stu_4
grant select on stu_4 to A

--12.������¼�˺�B������Ϊ456
create login B with password='456'
--13. �����û�B�������û�B��dbstudy�е�scinfo��Ĳ�ѯȨ�ޡ�
use dbstudy
create user B
grant select on sc
to B
--ɾ
drop user B
drop view stu_4
drop user A
drop view stu_avg
drop view stu_3
drop view stu_2
drop view stu_1
----------------------------����T-SQL��䡪����������ʵ������������������������
--1.���1-10���ż��
declare @num int----�������
set @num=1-----��ֵ
while @num<11
begin---------�����ſ�ʼ
if @num%2=0
begin 
print @num----���
end
set @num+=1 
end--------------�����Ž���
--2.���1-10�ĺ�
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
--3.�����쳣
--Ԥɾ���༶��ɾ��ǰ�����ɾ���༶���С���������ɾ���ɹ���������Ѿ�ɾ������
--�������ɾ���������������ɾ����
use dbstudy

begin try ------����еĴ�����ܲ�������ִ�У�������쳣�����Է���try����
  print 'ɾ���༶���С�����'------����ִ�е����
  drop  table  classinfo------�����쳣����������ִ��
  print'�Ѿ�ɾ��'   ----ǰһ������쳣������ֱ������catch���У���þ�û�б�ִ��
end try

begin catch------�����쳣��ֻ�г����쳣���Ż�����catch���еĴ���
   print '����ɾ��'
end catch 
--4.�ȴ�3�����ʾ��������>20��ѧ������
waitfor delay '00:00:03'
select * from studentinfo
where sage>20
--5.����һ��������t1,����ѧ������ɾ��ĳһ��ѧ����,��sc�����������ɾ��
create trigger t1 on   studentinfo
instead of delete
as
declare @studentID int
select @studentID=sid
from Deleted
delete from sc where sc.sid=@studentID
go
--6.ɾ��ѧ������һ����¼,ͨ���鿴��sc����ؼ�¼�Ƿ�ɾ��,��֤������t1�Ƿ�����
delete from studentinfo 
where sid=2

-------------------------------�洢����-------------------------
use dbstudy
select * from studentinfo 
select * from sc
----1.����һ���洢����p4,��ʾ��ѧ����������Ϣ,p4����һ������,���ڽ���ѧ��
create procedure p4   @a int           -------------------@aΪ��������������Ϊint
as
select * from studentinfo  
where sid=@a
----2.ִ�д洢����p4,����ѧ��Ϊ203��ѧ��������Ϣ
exec p4 203                             ---------------��203����@a
 
----3.�����洢����,����ָ��ѧ��ѧ����ƽ���ɼ�
create proc p8 @studentID int
as
select AVG(grade) as ƽ���ɼ� from sc 
where sid=@studentID
go

-----4.ִ�������洢���̣�����ѧ��Ϊ203��ѧ����ƽ���ɼ�
exec p8  203

--5����ʾ�����ݿ��ѧ��������Ϣ����������ڳ���ʱ����1995����ǰ��ѧ����������Щѧ�����б�
---�������һ����ʾ��Ϣ��˵��û������������ѧ����
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
--6��ʾ����ϵ��Ϊ���ƿơ���ѧ����Ϣ����������ʾ֮ǰ����ͣ1���ӣ�
waitfor delay '00:00:04'
select * from studentinfo
where sdept='�ƿ�'
--7������һ������,���԰�ѧ�Ų�ѯѧ��ѡ�޿ε�ƽ���ɼ���
--�����������ʾ��ѧ�ţ����������������ͬѧƽ���ɼ������񡯣�������� "ȫ��ͨ��"
create procedure p19 @a int 
as
 if exists(select AVG(grade) from studentinfo
     inner join sc on sc.sid=studentinfo.sid
     where studentinfo.sid=@a
     group by studentinfo.sid
     having AVG(grade)<60 )
 begin 
   print  '��ͬѧƽ���ɼ�������'
 end
else
    print   'ȫ��ͨ��'
 

 ---select * from sc
---update sc
--set grade=30
--where stid=6

 
  exec p19 203

--8������һ��������������ѧ����ִ��UPDARE����ʱ���ô��������������������޸�ѧ�����е�������
create trigger t100 on studentinfo for update
as
if (UPDATE(sname))
begin
print'�����޸�ѧ�����е�����'
rollback  transaction
end

else
print'�޸ĳɹ�'

update  studentinfo 
set sname=122

select  *  from studentinfo
--9����һ���洢���̣�������һ��������������ڽ���ѧ�ţ���ʾ��ѧ����������ѡ�޿εĿγ������ɼ�
create procedure p98 @a int 
as
 select sname,subname,grade from studentinfo
 inner join sc on studentinfo.sid=sc.sid
 inner join subjectinfo on sc.subid=subjectinfo.subid
 where studentinfo.sid=@a 

select * from sc
exec p98 203

--10������һ���洢���̣�������һ��������������ڽ���ѧ�źͷ�������ʾ��ѧ����������ѡ�޿εĿγ������ɼ���
create procedure p901 @a int ,@b int
as
 select sname,subname,grade from studentinfo
 inner join sc on studentinfo.sid=sc.sid
 inner join subjectinfo on sc.subid=subjectinfo.subid
 where studentinfo.sid=@a and grade=@b


select * from sc
exec p901 203,70

---------------------------------����--------------------------
--11.����
--�ȸ��İ༶���е�cidΪ2�ļ�¼��cnameΪ����ý��,��ɾ���༶��,
--�������ɾ��,��cidΪ2�ļ�¼Ҳ�����޸�
use dbstudy
select * from classinfo
begin try 
 begin tran----------��ʼ����
 update  classinfo 
 set cname='shumei'
 where cid=2

  drop  table  classinfo
 commit tran------------�ύ����
end try

 begin catch
   print('�޸�ʧ��')
   rollback tran------------�ع�����
 end catch
--12.����
 --���޸�cidΪ2�ļ�¼��cnameΪ3,�޸�cidΪ2�ļ�¼��cnameΪ4,
 --�޸�cidΪ2�ļ�¼��cnameΪ5.�������@num����ֵ,���@num<2��ִ��,����ع�,�����޸�
 select * from classinfo
declare @num int
set @num=1
 begin tran---------------��ʼ����

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
     commit tran-------�ύ����
 else 
     rollback tran-------�ع�����
--13.������ϰ��
--��1������һ��bank�������й˿�ID���˿��������˿���
use dbstudy
create table bank
(
id int primary key identity(1000,1),
name nvarchar(20) not null,
money money
)

drop table bank
select * from  bank
--��2�����bank��Լ����Ҫ��˿����>=1.
alter table bank 
add constraint check_currentMoney check(money>=1)
--��3�����������������ݡ�
insert into bank 
values('����',1000)
insert into bank 
values('����',1)

select * from bank

--��4���ӹ˿�1��ת�����˿�2.���õ�����
begin transaction
declare @error1 int,@error2 int
set @error1=0
set @error2=0
update bank 
set money=money-1000
where name='����'
set @error1=@@ERROR
update bank 
set money=money+1000
where name='����'
set @error2=@@ERROR

if(@error1=0 and @error2=0)
begin
print 'ת�˳ɹ�'
commit transaction
end
else
begin
print 'ת��ʧ��'
rollback transaction
end

--14.������ϰ
--��1�������༶����ţ�������������
use dbstudy
create table classinfo1
(cno int primary key,
 cname nvarchar(20),
 cnumber int check (cnumber>=0)
 )
--��2����༶���в���3�����ݡ�
insert into classinfo1
values(1,'����1',0),
   (2,'����2',0),
   (3,'����3',0)

select * from classinfo1
--��3������ѧ����ѧ�ţ���������ţ���ע������
create table studentinfo1
( sno int primary key,
sname nvarchar(20),
 cno int,
 foreign key (cno) references classinfo1(cno)
 )
--��4����ѧ���������һ����¼�����޸İ༶���ж�Ӧ������ֵ�����õ�����
begin try 
   begin tran
    insert into studentinfo1 
	values (12,'����',4)
	update classinfo1
	set cnumber=cnumber+1
	where cno=4
	commit tran
end try
begin catch
	  print '�޷�ִ��1'
	  rollback tran
end catch

select * from studentinfo1
select * from classinfo1
---------------------
declare @e1 int ,@e2 int
begin tran
    insert into studentinfo1 values (13,'����',3)
	set @e1=@@ERROR 
    update classinfo1
	 set cnumber=cnumber+1
	 where cno=3
	 set @e2=@@ERROR 
	 if (@e1=0  and @e2=0)
	    commit tran
	else 
	   begin
	   print '�޷�ִ��2'
	    rollback tran 
		end
select * from studentinfo1
select * from classinfo1





--------------------------���ٱ���--------------------------
---1. ���༶���е�������Ϣ���뵽һ�������ڵı�test1��
select  * into test1 from  classinfo

select * from test1

--2.��ѧ���ı�ṹ�����test5�У����ݲ�����
select  * into test5 from studentinfo
where 1=2                   -------ѡһ��ֵΪ�ٵı��ʽ����

select * from test5

---3.��ѧ�����е�ѧ���������Ա��Ƶ��Ѿ����ڵı�test5��--ѧ������stid���Զ���ֵ�ģ��������Զ���ֵ���ᱨ��

insert into test5(sname,sgender)
select sname,sgender from studentinfo

select * from test5

--�༶�ı�ṹ�����test5�У����ݲ����ƣ��ٰѰ������Ƶ��Ѿ����ڵı�test6��--�༶����cid���Զ���ֵ�ģ��������Զ���ֵ���ᱨ��
select  * into test6 from classinfo
where 1=2                   -------ѡһ��ֵΪ�ٵı��ʽ����


insert into test6(cname)
select cname from classinfo

select * from test6
-------------------------------����------------------------
--1.��studentinfo �а���ѧ�ź������ֱ�������
create index in1 on studentinfo(sid)
create index in2 on studentinfo(sname)

--2.ʹ�������������ŵ�ѧ����ѧ����Ϣ
select * from studentinfo
with(index(in2))
where sname like'��%'
