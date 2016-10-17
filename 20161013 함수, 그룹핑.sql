/*
<<SELECT ���� �������>>
  5.SELECT Į�� or ǥ����
  1.FROM ���̺��
  2.WHERE ���ǽ�
  3.GROUP BY �÷� or ǥ����
  4.HAVING �׷����ǽ�
  6.ORDER BY �÷� or ǥ���� //��Ī�� �� �� �ִ�.
*/

/*
GROUP BY �ۼ� ��ħ
 SELECT �� �ڿ� ����� �� �ִ� �÷��� GROUP BY �ڿ� ����� �÷� �Ǵ� �׷��Լ��� ����� �÷� �̾�� �Ѵ�.
 WHERE ���� ����Ͽ� ���� �׷����� �з��ϱ� ���� ���� ��ų �� �ִ�.
 GROUP BY �� �ڿ��� �÷� ��Ī�� ����� �� ����.
*/

--�μ��� �޿� �հ�, �޿����, �����
SELECT deptno, sum(sal) �޿���, round(avg(sal)) �޿����, count(*) �����--group by �� �÷� �Ǵ� �׷��Լ��� ����� �÷�
FROM EMP
Group BY DEPTNO;

--���� �޿��� 800�̻��̸鼭 �μ��� �޿����� 9000�̻��� �μ�(�׷�)�� ���
select deptno �μ���ȣ, sum(sal) �޿��հ�
from emp
where sal>800
group by deptno
having sum(sal) > 9000
ORDER BY �μ���ȣ ASC;

-- �μ���, ���޺� �޿���, �޿����
select deptno, job, empno, sum(sal) �޿���, avg(sal) �޿����
from emp
group by deptno, job, empno
order by deptno;


--������� -> decode�� case�Լ� ���
select deptno,
      DECODE(job, 'CLERK', sal) as "CLERK",
      decode(job, 'MANAGER', sal) as "MANAGER"
  from emp;


SELECT DEPTNO,
       DECODE(JOB,'CLERK',SAL) AS "CLERK",
       DECODE(JOB,'MANAGER',SAL) AS "MANAGER",
       DECODE(JOB,'PRESIDENT',SAL) AS "PRESIDENT",
       DECODE(JOB,'ANALYST',SAL) AS "ANALYST",
       DECODE(JOB,'SALESMAN',SAL) AS "SALESMAN"
FROM EMP;

--��ü����� ���޺�  �޿��հ�
SELECT
       SUM(DECODE(JOB,'CLERK',SAL)) AS "CLERK",
       SUM(DECODE(JOB,'MANAGER',SAL)) AS "MANAGER",
       SUM(DECODE(JOB,'PRESIDENT',SAL)) AS "PRESIDENT",
       SUM(DECODE(JOB,'ANALYST',SAL)) AS "ANALYST",
       SUM(DECODE(JOB,'SALESMAN',SAL)) AS "SALESMAN"
FROM EMP;



--�ǽ� ����
-- 1. ������̺��� �μ��� �ο����� 6�� �̻��� �μ��ڵ� �˻�?
select deptno, count(*) �ο���
from emp
group by deptno
having count(*) >= 6;


-- 2. ������̺�κ��� �μ���ȣ, ������ �޿��հ踦 ����ϰ����Ѵ�. 
--    ������ ���� ����� ����� �� �ִ� SQL����?

select DEPTNO,
        SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
        SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
        SUM(DECODE(job, 'PRESIDENT', sal)) as "PRESIDENT",
        SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
        SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
from emp
GROUP BY DEPTNO
ORDER BY DEPTNO;



-- 3. ������̺�κ��� �⵵�� , ���� �޿��հ踦 ����� �� �ִ�SQL��
SELECT EXTRACT(YEAR FROM HIREDATE)AS "��",
       EXTRACT(month FROM HIREDATE) AS "��",
       SUM(SAL) 
FROM EMP
GROUP BY HIREDATE
ORDER BY "��", "��";


-- 4. ������̺��� �μ��� comm(Ŀ�̼�) �� �������� ���� ������ �հ� 
--    ������ ������ ���� ���ϴ� SQL�� �ۼ��Ͻÿ�.
select deptno, sum(sal) ����
from emp
group by deptno;

select deptno, sum(sal+nvl(comm,0)) ����
from emp
group by deptno;



-- 5. ������̺��� SALESMAN�� ������ JOB�� �޿��հ�?
SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING JOB not like 'SALESMAN';


