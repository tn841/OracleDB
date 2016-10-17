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
-----------테스트용 테이블 생성----------------


/*
  SET연산자 - UNION, UNION ALL, INTERSECT, MINUS
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


-- COLUMN 불일치
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
이름     널        유형           
------ -------- ------------ 
DEPTNO NOT NULL NUMBER(2)    
DNAME           VARCHAR2(14) 
LOC             VARCHAR2(13) 
*/

INSERT INTO DEPT VALUES (90, '인사과', '서울');
INSERT INTO DEPT VALUES (80, '인사과', '서울');
INSERT INTO DEPT(LOC, DNAME, DEPTNO) VALUES ('LA', '영업부', 70);
INSERT INTO DEPT(DEPTNO, DNAME) VALUES (91, '생산부');

SELECT * FROM DEPT;



DESCRIBE EMP;
/*
이름       널        유형           
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
INSERT INTO EMP VALUES(9000, USER, '연구원', 7839, SYSDATE, 5000, NULL, 90);
INSERT INTO EMP VALUES (9001,'홍길동','MANAGER',7839,TO_DATE('2016/10/10','YYYY/MM/DD'),2000,NULL,30);




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
SET DNAME='경리과'
WHERE DEPTNO=90;

UPDATE DEPT
SET LOC='부산'
WHERE DEPTNO=90;

SELECT * FROM DEPT WHERE DEPTNO=91;
UPDATE DEPT
SET LOC='인천',DNAME='생산팀'
WHERE DEPTNO=91;

UPDATE DEPT 
SET LOC='서울';

SELECT * FROM DEPT;

UPDATE DEPT 
SET LOC='서울'
WHERE DEPTNO=99;
--조건에 만족하는데이타가없으면 -->
--0개 행 이(가) 업데이트되었습니다.

UPDATE DEPT
SET LOC=LOC||'1';

INSERT INTO DEPT_1 VALUES (122323, 'dd', 'dd');

--DELETE
SELECT * FROM DEPT;
DELETE FROM DEPT
WHERE DEPTNo=91;

DELETE DEPT 
WHERE DEPTNO IN(80,70,91,92,93);
-- 90번부서삭제(90번부서 참조하고있는 EMP를 삭제한후)
DELETE EMP WHERE DEPTNO=90;
DELETE DEPT WHERE DEPTNO=90;


DELETE EMP 
WHERE DEPTNO=(
              SELECT DEPTNO 
              FROM DEPT 
              WHERE DNAME='SALES');


--transaction
COMMIT;



