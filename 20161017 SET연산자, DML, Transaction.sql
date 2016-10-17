---------------------------------------------
drop table A;
drop table B;

create table A(val char);
create table B(num number,val char);

insert into A values('A');
insert into A values('B');
insert into A values('C');
insert into A values('D');
insert into A values('E');

insert into B values(1,'C');
insert into B values(2,'D');
insert into B values(3,'E');
insert into B values(4,'F');
insert into B values(5,'G');
commit;
-----------�׽�Ʈ�� ���̺� ����----------------


/*
  SET������ - UNION, UNION ALL, INTERSECT, MINUS
*/

--UNION
SELECT VAL FROM A
UNION
SELECT VAL FROM B;

--UNION ALL
SELECT VAL FROM A
UNION
SELECT VAL FROM B;

--INTERSECT
SELECT VAL FROM A
INTERSECT
SELECT VAL FROM B;

-- MINUS
SELECT VAL FROM A
MINUS
SELECT VAL FROM B;


-- COLUMN ����ġ
SELECT NULL, VAL FROM A
UNION
SELECT NULL, VAL FROM B;



-----------------------------
-----------------------------
----------------------------------------------------------
-----------------------------
----------------------------------------------------------
----------------------------------------------------------

/* DML (Data Management Language) */

--INSERT
DESCRIBE DEPT;
/*
�̸�     ��        ����           
------ -------- ------------ 
DEPTNO NOT NULL NUMBER(2)    
DNAME           VARCHAR2(14) 
LOC             VARCHAR2(13) 
*/

INSERT INTO DEPT VALUES (90, '�λ��', '����');
INSERT INTO DEPT VALUES (80, '�λ��', '����');
INSERT INTO DEPT(LOC, DNAME, DEPTNO) VALUES ('LA', '������', 70);
INSERT INTO DEPT(DEPTNO, DNAME) VALUES (91, '�����');

SELECT * FROM DEPT;



DESCRIBE EMP;
/*
�̸�       ��        ����           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2) 
*/
INSERT INTO EMP VALUES(9000, USER, '������', 7839, SYSDATE, 5000, NULL, 90);
INSERT INTO EMP VALUES (9001,'ȫ�浿','MANAGER',7839,TO_DATE('2016/10/10','YYYY/MM/DD'),2000,NULL,30);




CREATE TABLE DEPT_1(
  DEPTNO NUMBER(2),
  DNAME VARCHAR2(10),
  LOC VARCHAR2(10)
);
INSERT INTO DEPT_1(DEPTNO,DNAME,LOC)
SELECT DEPTNO,DNAME,LOC FROM DEPT;

--UPDATE
SELECT * FROM DEPT WHERE DEPTNO=90;
UPDATE DEPT
SET DNAME='�渮��'
WHERE DEPTNO=90;

UPDATE DEPT
SET LOC='�λ�'
WHERE DEPTNO=90;

SELECT * FROM DEPT WHERE DEPTNO=91;
UPDATE DEPT
SET LOC='��õ',DNAME='������'
WHERE DEPTNO=91;

UPDATE DEPT 
SET LOC='����';

SELECT * FROM DEPT;

UPDATE DEPT 
SET LOC='����'
WHERE DEPTNO=99;
--���ǿ� �����ϴµ���Ÿ�������� -->
--0�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE DEPT
SET LOC=LOC||'1';

INSERT INTO DEPT_1 VALUES (122323, 'dd', 'dd');

--DELETE
SELECT * FROM DEPT;
DELETE FROM DEPT
WHERE DEPTNo=91;

DELETE DEPT 
WHERE DEPTNO IN(80,70,91,92,93);
-- 90���μ�����(90���μ� �����ϰ��ִ� EMP�� ��������)
DELETE EMP WHERE DEPTNO=90;
DELETE DEPT WHERE DEPTNO=90;


DELETE EMP 
WHERE DEPTNO=(
              SELECT DEPTNO 
              FROM DEPT 
              WHERE DNAME='SALES');


--transaction
COMMIT;



