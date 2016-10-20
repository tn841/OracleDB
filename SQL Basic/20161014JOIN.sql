/* 
  ANSI JOIN 
*/
-- 1. Catasian Product
select empno, ename, dname
from dept, emp;

-- 2. Equi-Join
SELECT EMP.EMPNO, EMP.ENAME, DEPT.DNAME, DEPT.LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO; --�� ���ǹ������� EQUI-JOIN�� �����.

SELECT e.EMPNO "���", e.ENAME �̸�, d.DNAME �μ�, d.LOC ��ġ
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.ENAME like '%A%';


-- 3, Non-EquiJoin
SELECT e.ENAME, e.SAL, s.GRADE
FROM EMP e, SALGRADE s
WHERE e.SAL >= s.LOSAL AND e.SAL <= s.HISAL; 
-- �ܷ�Ű�� ����Ǿ� ���� ������,, 
-- SALGRADE�� LOSAL�� HISAL������ �������� ������ �Űܼ� JOIN.

SELECT e.ENAME, e.SAL, s.GRADE
FROM EMP e, SALGRADE s
WHERE  e.sal between s.LOSAL and s.HISAL;

-- 4. Outer Join : �������ǿ� �������� ����, ������ ����� �����Ͽ� ���
SELECT e.EMPNO, e.ENAME, d.DNAME, d.LOC
FROM EMP e, DEPT d
WHERE e.deptno (+) = d.deptno;
-- ��Ī�Ǵ� ������ ���� �μ� (OPERATIONS)�� ������ ��µȴ�.

SELECT e.EMPNO, e.ENAME, d.DNAME, d.LOC
FROM EMP e, DEPT d
WHERE e.deptno = d.deptno (+);
-- ��Ī�Ǵ� �μ��� ���� ���� (KING)�� ������ ��µ�.
-- (+) �ƿ��� ���� �����ڸ� ���ʿ� ���� ���� ����.


-- 5. Self Join : �ڱ� �ڽ��� Join �ϴ� ��.
SELECT e.EMPNO, e.Job, e.ENAME, m.ENAME ������
FROM EMP e, EMP m
where e.mgr = m.empno (+);
-- ��Ī�Ǵ� �Ŵ����� ���� ����(KING)�� ���� ���


/* 
  SQL 1999(SQL3) JOIN 
    : Join�� ������ From ������ �����ȴ�.
    : Join������ Where ���� �ƴ� On������ ��õ�
*/
-- 1. Cross Join (= Catesian Product�� ����)
SELECT e.EMPNO, e.ENAME, d.DNAME
FROM EMP e CROSS JOIN DEPT d;

SELECT e.EMPNO, e.ENAME, d.DNAME
FROM EMP e, DEPT d;


-- 2. Natural Join (= Equi Join�� ����)
SELECT *
FROM EMP NATURAL JOIN DEPT; --DEPTNO��� ������ �÷����� �Ѱ��̹Ƿ� �˾Ƽ� ���� ��Ŵ

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP
JOIN DEPT
USING (DEPTNO); --USING ���, ���� DEPTNO���� ������ �÷����� �� �������, USING���� � �÷��� �������� ���� ��ų�� ����� �ش�.


-- 3. JOIN ~ ON�� �̿��� JOIN
--   : NON-EquiJoin�̳� ������ ������ ������ �� ��
SELECT *
FROM EMP JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = 10; --where ��� on

-- ���̺� 3�� ����
SELECT e.EMPNO, e.ENAME, d.DNAME, s.GRADE
FROM EMP e JOIN DEPT d
      ON e.DEPTNO = d.DEPTNO
      JOIN SALGRADE s
      ON e.SAL BETWEEN s.LOSAL AND s.HISAL
      ORDER BY s.GRADE;


-- 4. Outer Join
SELECT e.EMPNO, e.ENAME, d.DNAME
FROM EMP e LEFT OUTER JOIN DEPT d
ON e.DEPTNO = d.DEPTNO;
--����(����)�� ��ġ ���ο� ������� ��� ���

SELECT e.EMPNO, e.ENAME, d.DNAME
FROM EMP e FULL OUTER JOIN DEPT d
ON e.DEPTNO =  d.DEPTNO;
-- ��, ���� ��ġ ���� ��� ���� ��� ���





/* �ǽ� ���� */
-- 1. DEPT�� EMP���� EMPNO, ENAME, DEPTNO, DNAME�� �˻��Ͻÿ�.
SELECT e.EMPNO, e.ENAME, d.DEPTNO, d.DNAME
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO;


-- 2. DEPT�� EMP���� ���, �����, �޿�, �μ����� �˻��Ͻÿ�
--    ��, �޿��� 2000�̻��� ����� ���Ͽ� �޿��������� �������� ����
SELECT e.EMPNO, e.ENAME, e.SAL, d.DNAME
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO AND e.SAL >=2000
ORDER BY e.SAL;



-- 3. �μ����̺�� ������̺��� ���, �����, ����, �޿�, �μ����� �˻�
--    ��, ������ Mananger�̸� �޿��� 2500�̻��� ����� ���Ͽ�
--    ����� �������� �������� ������ ��.
SELECT  e.EMPNO, e.ENAME, e.JOB, e.SAL, d.DNAME
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO AND e.JOB LIKE 'MANAGER' AND e.SAL >= 2500
ORDER BY e.EMPNO;


-- 4. ��� ���̺�� �޿���� ���̺��� ���, �����, �޿�, ����� �˻�,
--    ��, ����� �޿��� ���Ѱ��� ���Ѱ� ������ ���Եǰ� ����� 4�̸�
--    �޿��������� �������������� ��.
SELECT e.EMPNO, e.ENAME, e.SAL, s.GRADE
FROM EMP e JOIN SALGRADE s 
ON e.SAL between s.LOSAL AND s.HISAL AND s.GRADE = 4
ORDER BY e.SAL DESC;

-- 5. �μ����̺�, ������̹�, �޿�������̺��� 
--    ���, �����, �μ���, �޿�, ����� �˻�
--    ��, ����� �޿��� ���Ѱ��� ���Ѱ� ������ ���ԵǸ�
--    ����� �������� �������� ������ ��.
SELECT e.EMPNO, e.ENAME, d.DNAME, e.SAL, s.GRADE
FROM EMP e JOIN DEPT d
      ON e.DEPTNO = d.DEPTNO
      JOIN SALGRADE s
      ON e.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY s.GRADE;


-- 6. ������̺��� ������ �ش� ����� �����ڸ��� �˻�
SELECT e.ENAME �����, m.ENAME �����ڸ�
FROM EMP e JOIN EMP m
ON e.EMPNO = m.MGR;



-- 7. ��� ���̺��� �����, �ش� ����� �����ڸ�, �ش� ����� �������� �����ڸ��� �˻�
SELECT e.ENAME ���, m.ENAME �����ڸ�, mm.ENAME "�������� ������"
FROM EMP e JOIN EMP m
ON e.MGR = m.EMPNO
JOIN EMP mm ON m.MGR = mm.EMPNO;


-- 8. 7�� ������� ���� �����ڰ� ���� ��� ����� �̸��� ����� ��µǵ��� ����
SELECT e.ENAME ���, m.ENAME �����ڸ�, mm.ENAME "�������� ������"
FROM EMP e LEFT OUTER JOIN EMP m
ON e.MGR = m.EMPNO
LEFT OUTER JOIN EMP mm ON m.MGR = mm.EMPNO;






/*
    �������� Subquery
      : Select���� ���ԵǾ� �ִ� �� �ϳ��� Select���� subquery��� �Ѵ�.
        ���������� ���� ����ǰ� ���� ������ �� ���� ����
        ���������� WHERE�� HAVING�� FROM������ ����� �� �ִ�.
        ���������� �ݵ�� ��ȣ�ȿ� �ۼ��ؾ� �Ѵ�.
        ������������ ORDER BY ���� ����� �� ����.
*/




/*
--��������(sub query)
*/

SELECT EMPNO,ENAME
FROM EMP
WHERE SAL > (SELECT SAL
              FROM EMP
              WHERE ENAME = 'SCOTT');
/*
   A.�������� ��ġ�� ���� ����
      ? SELECT �� �� ��Į�� ��������
      ? FROM �� �� �ڡڡ��ζ��� ��ڡڡ� ���� Ȯ���� ����
      ? WHERE �� �� Nested ��������, ��Į�� ��������
      ? GROUP BY �� �� ��Į�� ��������
      ? HAVING �� �� ��Į�� ��������
      ? ORDER BY �� �� ��Į�� ��������
      
  B.��Į�� ��������(scalar subquery)
  
      1.��Į�� ��������(scalar subquery)
        - �ϳ��� SQL������ ��޵����� ���������� �ϳ��� �Լ��� �����ϸ��
        - �Լ��� ����ūƯ¡�� ���� INPUT �� �ִ��� OUTPUT�� �ϳ��� ���´ٴ°��Դϴ�.
        - ��Į�� ���������� ������ �Լ��̹Ƿ� ��ø�ؼ� ��밡���ϳ� 
          OUTPUT�� �ΰ� �̻��̰ų�,OUTPUT�� ����ŸŸ���� �����ʴ� ��쿡�� ������ �߻���ŵ�ϴ�.
        - �뷮�� ����Ÿó���� ��Į�������� ������ �������ϸ� �����Ҽ������Ƿ�
          �������� ��ü�ϴ°��� �����ϴ�. 
      2.��Į�� ��������(scalar subquery)��ġ
        - SELECT LIST �׸�
        - �Լ��� ����
        - WHERE���� ����
        - ORDER BY ��
        - CASE ������
        - CASE �����
      3.�뷮�� ����Ÿ ó���� �������ΰǸ��� ����Ǵ� ��Į�󼭺������� �����ϴ°���
        �뷮�� ����Ÿ�� �Ѳ����� ó���Ҽ��ִ� �����������̳� ������ ������ �ۿ��ϱ� 
        ����� ������ �����ϸ� ��Į�󼭺��������ƴ϶� �������� ��ü�ϴ°��� �����ϴ�.
 
  C.INLINE VIEW (subquery)   
   1. INLINE VIEW �ʿ伺
     ?���ǹ��� FROM ���� ���̺� ��� �����ϴٸ� ���� �ӽ� ���̺��� ������ �� ���Դϴ�.
         �������� �����ͺ��̽������� ���� ��ü�� �����Ͽ� �̷��� ���̺��� ���� ������ 
         ���ǹ��� ���·� ǥ���Ͽ� ������ �� �ֵ��� �ϰ� �ֽ��ϴ�. 
         �׷���, �� ���� �����ͺ��̽��� ����Ǵ� ��ü�̱� ������ 
         �� ���� �������� �����ϱⰡ ��ƽ��ϴ�.
    ?�̷��� ������ �غ��� �� �ֵ��� ����Ŭ������ 7 �������� 
        ���ǹ��� FROM �� ��ü�� ���������� ����� �� �ִ� ����� �����մϴ�. 
        �� ���������� �ζ��� ���� �θ��� ���ǹ��� �ܼ�ȭ �� ���� ��� ȿ���� ���� �� �ֽ��ϴ�.
    ?�ζ��� ��� ���̺�� ��ó�� �����ͺ��̽��� ����Ǵ� ��ü�� �ƴϰ�,
        ���ǹ����� ��ó�� ���Ǵ� ��Ī(Alias)�� ���� ���������Դϴ�. 
        �������� �߿����� FROM ���� ���� ���� ��Ÿ���� �����ν� 
        WHERE ���� ���Ǵ� ���� ��Ÿ���� Nested ���������� 255 ���� ���Ѱ��� �ٸ���
        Top-Level ���ǹ��� ���Ͽ� �� ���� ������ �����ϴ�. 
        ��� ������ �����ϸ� �ӽ÷� ������� ������ �������ٴ� Ư¡�� �ֽ��ϴ�.
        
  2.INLINE VIEW Ư¡
    ?SELECT ���� FROM ���� Subquery�� ����� �� �ִµ� ��� ����� VIEW�� �����ϸ�, 
        Ư���� INLINE VIEW��� Ī�մϴ�.
    ?SELECT���� FROM���� �ִ� Subquery �� Ư�� SELECT ���� ���� ������ �ҽ��� �����ϸ� 
        �ش� SELECT ���� ���ؼ��� �����մϴ�.
    ?NLINE VIEW �� SQL���� �������� ��ȿ�� Temporary VIEW �̹Ƿ�,
        VIEW �ʹ� �޸� Database Object �� �ƴմϴ�.
    ?��, INLINE VIEW �� Subquery ������ �̿��� �ӽ� ���� �� �� �ֽ��ϴ�.
    ?SQL�� Ȱ����.....  `������ ����Ǳ� ������ 
        Non Procedural ����� SQL�� �������� ����� �ο��� ���� ������ ����Դϴ�.
  3.INLINE VIEW�� Ȱ�� 
      - ���� ȸ���� ����
      - �������� ���� �ζ��� ���� Ȱ��
        
 */
 
-- ��Į�� ��������
-- 1. SELECT COL              
SELECT EMPNO, ENAME, SAL, 
        (SELECT GRADE FROM SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL) GRADE
FROM EMP;

SELECT EMPNO, ENAME,
        (SELECT DNAME FROM DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO) �μ��̸�,
        (SELECT LOC FROM DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO) �μ���ġ
FROM EMP;


-- 2. �Լ��� ����
SELECT EMPNO, ENAME, 
      INITCAP((SELECT DNAME FROM DEPT d WHERE d.DEPTNO = e.DEPTNO)) as DNAME
FROM EMP e;

-- 3. WHERE���� ����
SELECT EMPNO, ENAME, SAL 
FROM EMP
WHERE SAL >
(SELECT SAL 
FROM EMP WHERE ENAME='SCOTT');



SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB
              FROM EMP
              WHERE EMPNO=7844);
              
              
-- ������ ������ (IN, ANY, ALL)


  -- IN
  --�μ��� �ּ� �ӱݵ� (950, 800, 1300)
SELECT DEPTNO, MIN(SAL)
FROM EMP
GROUP BY DEPTNO;


  --�μ��� �ּ� �ӱ��� �޴� ����� ���� ���
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN (
            (SELECT MIN(SAL)
            FROM EMP
            GROUP BY DEPTNO) -- 950, 800, 1300
            );               -- ���������� �ݵ�� ��ȣ!


SELECT *
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                FROM EMP
                WHERE ENAME='SCOTT');
                

  -- ALL
  -- ��� ���̺��� ������ MANAGER�� ����� �޿��麸�� ���� �޿��� ���� ����
SELECT SAL FROM EMP WHERE JOB='MANAGER'; -- 2975, 2850, 2450

SELECT *
FROM EMP
WHERE SAL < ALL (2975, 2850, 2450); -- ���� ������ ��ΰ� �����ϴ� �����͸� ã��

SELECT *
FROM EMP
WHERE SAL < ALL(SELECT SAL FROM EMP WHERE JOB='MANAGER');



  -- ANY
  -- MANAGER�� �޿����� ���� �޿��� �޴� ������� �̸��� �˻�
SELECT SAL FROM EMP WHERE JOB='MANAGER'; -- 2975, 2850, 2450

SELECT *
FROM EMP
WHERE SAL > ANY(2975, 2850, 2450);  --2450 ���� ũ�� ����

SELECT *
FROM EMP
WHERE SAL > ANY((SELECT SAL FROM EMP WHERE JOB='MANAGER'));

SELECT *
FROM EMP
WHERE SAL = ANY(
                SELECT MAX(SAL)
                FROM EMP
                GROUP BY DEPTNO
                );
                
                
                
                
                
                
                
                
                
                
/*
    �ǽ�����
*/

-- 1. ��� ���̺��� BLAKE ���� �޿��� �Ĥ��� ������� ��� �̸� �޿��� �˻�
SELECT e.EMPNO, e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL > (
                SELECT SAL
                FROM EMP
                WHERE ENAME LIKE 'BLAKE'
              );
              


-- 2. ��� ���̺��� MILLER ���� �ʰ� �Ի��� ����� ��� �̸� �Ի��� �˻�
SELECT e.EMPNO, e.ENAME, TO_CHAR(e.HIREDATE, 'DD') �Ի���
FROM EMP e
WHERE TO_NUMBER(TO_CHAR(e.HIREDATE, 'DD')) > (
              SELECT TO_NUMBER(TO_CHAR(e.HIREDATE, 'DD'))
                FROM EMP e
                WHERE ENAME LIKE 'MILLER'
              );

 SELECT TO_NUMBER(TO_CHAR(e.HIREDATE, 'DD'))
                FROM EMP e
                WHERE ENAME LIKE 'MILLER';

-- 3. ��� ���̺��� ��� ��ü ��� �޿����� �޿��� ���� ������� ���, �̸�, �޿��� �˻�
SELECT e.EMPNO, e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL > (
              SELECT AVG(e.SAL)
                FROM EMP e
              );
              
              SELECT AVG(e.SAL)
                FROM EMP e;


-- 4. ��� ���̺��� CLARK�� ���� �μ��̸�, ����� 7698�� ������ �޿����� ���� �޿��� �޴� �������
--     ������� ���, �̸�, �޿��� �˻�
SELECT e.EMPNO, e.ENAME, e.SAL
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE e.JOB LIKE (
                SELECT JOB
                FROM EMP
                WHERE ENAME LIKE 'CLARK' 
              ) AND 
              e.SAL > (
                SELECT SAL
                FROM EMP
                WHERE EMPNO = 7698
              );
              
             SELECT JOB
                FROM EMP
                WHERE ENAME LIKE 'CLARK';
                
              SELECT SAL
              FROM EMP
              WHERE EMPNO = 7698;


-- 5. ��� ���̺��� �μ��� �ִ� �޿��� �޴� ������� ���, �̸�, �μ��ڵ�, �޿��� �˻�
SELECT *
FROM EMP e 
WHERE SAL IN (SELECT MAX(SAL)
          FROM EMP
          GROUP BY DEPTNO);

SELECT *
FROM EMP
WHERE SAL = ANY(
                SELECT MAX(SAL)
                FROM EMP
                GROUP BY DEPTNO
                );
                



