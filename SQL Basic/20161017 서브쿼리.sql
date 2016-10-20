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
 ODER BY�� subquery ���
*/
SELECT EMPNO, ENAME,DEPTNO,       
      ( SELECT DNAME FROM DEPT WHERE DEPTNO = e.DEPTNO ) AS "DNAME"
FROM EMP e
ORDER BY (SELECT DNAME FROM DEPT WHERE DEPTNO = e.DEPTNO);


SELECT EMPNO,
       ENAME,
       DEPTNO,
       (
        SELECT DNAME FROM DEPT WHERE DEPTNO = e.DEPTNO
       ) AS "�μ��̸�"
FROM EMP e
ORDER BY �μ��̸�;



/*
  CASE ������,�����
*/

SELECT  EMPNO,
        ENAME,
        DEPTNO,
        (
         CASE WHEN DEPTNO=20
         THEN 'ACCOUNTING' 
         ELSE 'SALES'
         END
        ) AS "���μ�"
FROM EMP;        

SELECT  EMPNO,
        ENAME,
        DEPTNO,
        (
         CASE WHEN DEPTNO=20
         THEN (SELECT DNAME FROM DEPT WHERE DEPTNO=10) 
         ELSE (SELECT DNAME FROM DEPT WHERE DEPTNO=30)
         END
        ) AS "�ٲ�μ�"
FROM EMP
ORDER BY "�ٲ�μ�" ASC; 


--��Į�� ���������� JOIN�Ǻ�

SELECT e.EMPNO,e.ENAME,d.DNAME,d.LOC
FROM EMP e 
     JOIN
     DEPT d
     ON e.DEPTNO=d.DEPTNO;

SELECT  e.EMPNO,
        e.ENAME,
        (
          SELECT DNAME FROM DEPT d WHERE d.DEPTNO=e.DEPTNO
        ) as �μ��̸�,
        (
          SELECT LOC FROM DEPT d WHERE d.DEPTNO=e.DEPTNO
        ) as �μ���ġ
FROM EMP e;


--INLINE VIEW(��������)
-------------- CASE1 ----------------
----A. NO INLINE VIEW------
SELECT DEPTNO,AVG(SAL) AS "DEPT_AVG_SAL"
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL)>2000;

----B. INLINE VIEW------
SELECT DEPTNO,AVG(SAL) FROM EMP GROUP BY DEPTNO;

SELECT �μ�����ձ޿����̺�.*
FROM ( SELECT DEPTNO, AVG(SAL) AS �μ����
       FROM EMP 
       GROUP BY DEPTNO
      ) �μ�����ձ޿����̺�
WHERE �μ�����ձ޿����̺�.�μ���� > 2000;


-------------- CASE2 ----------------
------A. No Inline View ----
SELECT d.DNAME, e.DEPTNO, AVG(e.SAL) AS �μ����
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
GROUP BY d.DNAME, e.DEPTNO
HAVING �μ���� > 2000;

-----B. Inline View ----
SELECT DEPTNO, AVG(SAL) FROM EMP GROUP BY DEPTNO;

SELECT *
FROM (  SELECT DEPTNO, AVG(SAL) �μ����
        FROM EMP
        GROUP BY DEPTNO) dAVG_T JOIN DEPT d
ON dAVG_T.DEPTNO = d.DEPTNO
WHERE dAVG_T.�μ���� > 2000;


-- �������� ���� �ζ��κ��� Ȱ��
/*
  ������ ��ձ޿����� �޿��� ���� ����� �������
  ������ ��ձ޿��� 10% �ʰ��ϴ� ����� �޿��� 5% ����
*/

-- 1. ������ ��ձ޿�
SELECT JOB, AVG(SAL)
FROM EMP
GROUP BY JOB;

-- 2. ������ ��ձ޿����� �޿��� ���� ���
SELECT e2.ENAME,e2.JOB, e_avg, e2.SAL, round(e2.SAL/e_avg * 100,1) "����ӱ� ���"
FROM (SELECT JOB, AVG(SAL) e_avg
      FROM EMP
      GROUP BY JOB) e1 JOIN EMP e2
ON e1.JOB = e2.JOB
WHERE e2.SAL > e1.e_avg;

-- 3. ��� �޿��� 10%�ʰ��ϴ� ���
SELECT e2.ENAME,e2.JOB, e_avg, e2.SAL
FROM (SELECT JOB, AVG(SAL) e_avg
      FROM EMP
      GROUP BY JOB) e1 JOIN EMP e2
ON e1.JOB = e2.JOB
WHERE e2.SAL > (e1.e_avg + e1.e_avg*0.1);

-- 4. ��� �޿��� 10%�ʰ��ϴ� ����� �޿��� 5% ����
SELECT result_T.ENAME, result_T.SAL "CURRENT_SAL", result_T.SAL - result_T.SAL*0.05 "NEW_SAL"
FROM (SELECT e2.ENAME,e2.JOB, e_avg, e2.SAL
      FROM (SELECT JOB, AVG(SAL) e_avg
            FROM EMP
            GROUP BY JOB) e1 JOIN EMP e2
      ON e1.JOB = e2.JOB
      WHERE e2.SAL > (e1.e_avg + e1.e_avg*0.1)) result_T;
      
      
      
      
      
      
--VIEW ����
--"insufficient privileges" -> sys�������� ���� ������� 'SCOTT'���� VIEW ���� ���� �߰��ϸ� �ذ�� GRANT CREATE VIEW TO SCOTT;
CREATE VIEW EMP_DEMP
AS
SELECT EMPNO, ENAME, DNAME, LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;





