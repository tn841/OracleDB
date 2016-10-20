/* 
  ANSI JOIN 
*/
-- 1. Catasian Product
select empno, ename, dname
from dept, emp;

-- 2. Equi-Join
SELECT EMP.EMPNO, EMP.ENAME, DEPT.DNAME, DEPT.LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO; --이 조건문때문에 EQUI-JOIN이 수행됨.

SELECT e.EMPNO "사번", e.ENAME 이름, d.DNAME 부서, d.LOC 위치
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.ENAME like '%A%';


-- 3, Non-EquiJoin
SELECT e.ENAME, e.SAL, s.GRADE
FROM EMP e, SALGRADE s
WHERE e.SAL >= s.LOSAL AND e.SAL <= s.HISAL; 
-- 외래키로 연결되어 있지 않지만,, 
-- SALGRADE의 LOSAL과 HISAL범위를 기준으로 조건을 매겨서 JOIN.

SELECT e.ENAME, e.SAL, s.GRADE
FROM EMP e, SALGRADE s
WHERE  e.sal between s.LOSAL and s.HISAL;

-- 4. Outer Join : 조인조건에 만족하지 않은, 누락된 행까지 포함하여 출력
SELECT e.EMPNO, e.ENAME, d.DNAME, d.LOC
FROM EMP e, DEPT d
WHERE e.deptno (+) = d.deptno;
-- 매칭되는 직원이 없는 부서 (OPERATIONS)의 정보도 출력된다.

SELECT e.EMPNO, e.ENAME, d.DNAME, d.LOC
FROM EMP e, DEPT d
WHERE e.deptno = d.deptno (+);
-- 매칭되는 부서가 없는 직원 (KING)의 정보도 출력됨.
-- (+) 아우터 조인 연산자를 양쪽에 붙일 수는 없다.


-- 5. Self Join : 자기 자신을 Join 하는 것.
SELECT e.EMPNO, e.Job, e.ENAME, m.ENAME 관리자
FROM EMP e, EMP m
where e.mgr = m.empno (+);
-- 매칭되는 매니저가 없는 직원(KING)의 정보 출력


/* 
  SQL 1999(SQL3) JOIN 
    : Join의 형식이 From 절에서 지정된다.
    : Join조건이 Where 절이 아닌 On절에서 명시됨
*/
-- 1. Cross Join (= Catesian Product와 동일)
SELECT e.EMPNO, e.ENAME, d.DNAME
FROM EMP e CROSS JOIN DEPT d;

SELECT e.EMPNO, e.ENAME, d.DNAME
FROM EMP e, DEPT d;


-- 2. Natural Join (= Equi Join과 동일)
SELECT *
FROM EMP NATURAL JOIN DEPT; --DEPTNO라는 동일한 컬럼명이 한개이므로 알아서 조인 시킴

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP
JOIN DEPT
USING (DEPTNO); --USING 사용, 만약 DEPTNO말고 동일한 컬럼명이 또 있을경우, USING으로 어떤 컬럼을 기준으로 조인 시킬지 명시해 준다.


-- 3. JOIN ~ ON을 이용한 JOIN
--   : NON-EquiJoin이나 복잡한 조건의 조인을 할 때
SELECT *
FROM EMP JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = 10; --where 대신 on

-- 테이블 3개 조인
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
--좌측(직원)이 일치 여부와 상관없이 모두 출력

SELECT e.EMPNO, e.ENAME, d.DNAME
FROM EMP e FULL OUTER JOIN DEPT d
ON e.DEPTNO =  d.DEPTNO;
-- 좌, 우측 일치 여부 상관 없이 모두 출력





/* 실습 문제 */
-- 1. DEPT와 EMP에서 EMPNO, ENAME, DEPTNO, DNAME을 검색하시오.
SELECT e.EMPNO, e.ENAME, d.DEPTNO, d.DNAME
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO;


-- 2. DEPT와 EMP에서 사번, 사원명, 급여, 부서명을 검색하시오
--    단, 급여가 2000이상인 사원에 대하여 급여기준으로 내림차순 정렬
SELECT e.EMPNO, e.ENAME, e.SAL, d.DNAME
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO AND e.SAL >=2000
ORDER BY e.SAL;



-- 3. 부서테이블과 사원테이블에서 사번, 사원명, 업무, 급여, 부서명을 검색
--    단, 업무가 Mananger이며 급여가 2500이상인 사원에 대하여
--    사번을 기준으로 오름차순 정렬할 것.
SELECT  e.EMPNO, e.ENAME, e.JOB, e.SAL, d.DNAME
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO AND e.JOB LIKE 'MANAGER' AND e.SAL >= 2500
ORDER BY e.EMPNO;


-- 4. 사원 테이블과 급여긍급 테이블에서 사번, 사원명, 급여, 등급을 검색,
--    단, 등급은 급여가 하한값과 상한값 범위에 포함되고 등급이 4이며
--    급여기준으로 내림차순정렬할 것.
SELECT e.EMPNO, e.ENAME, e.SAL, s.GRADE
FROM EMP e JOIN SALGRADE s 
ON e.SAL between s.LOSAL AND s.HISAL AND s.GRADE = 4
ORDER BY e.SAL DESC;

-- 5. 부서테이블, 사원테이벌, 급여등급테이블에서 
--    사번, 사원명, 부서명, 급여, 등급을 검색
--    단, 등급은 급여가 하한값과 상한값 범위에 포함되며
--    등급을 기준으로 내림차순 정렬할 것.
SELECT e.EMPNO, e.ENAME, d.DNAME, e.SAL, s.GRADE
FROM EMP e JOIN DEPT d
      ON e.DEPTNO = d.DEPTNO
      JOIN SALGRADE s
      ON e.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY s.GRADE;


-- 6. 사원테이블에서 사원명과 해당 사원의 관리자명을 검색
SELECT e.ENAME 사원명, m.ENAME 관리자명
FROM EMP e JOIN EMP m
ON e.EMPNO = m.MGR;



-- 7. 사원 테이블에서 사원명, 해당 사원의 관리자명, 해당 사원의 관리자의 관리자명을 검색
SELECT e.ENAME 사원, m.ENAME 관리자명, mm.ENAME "관리자의 관리자"
FROM EMP e JOIN EMP m
ON e.MGR = m.EMPNO
JOIN EMP mm ON m.MGR = mm.EMPNO;


-- 8. 7번 결과에서 상위 관리자가 없는 모든 사원의 이름도 사원명에 출력되도록 수정
SELECT e.ENAME 사원, m.ENAME 관리자명, mm.ENAME "관리자의 관리자"
FROM EMP e LEFT OUTER JOIN EMP m
ON e.MGR = m.EMPNO
LEFT OUTER JOIN EMP mm ON m.MGR = mm.EMPNO;






/*
    서브쿼리 Subquery
      : Select문에 포함되어 있는 또 하나의 Select문을 subquery라고 한다.
        서브쿼리가 먼저 실행되고 메인 쿼리가 그 다음 실행
        서브쿼리는 WHERE절 HAVING절 FROM절에서 사용할 수 있다.
        서브쿼리는 반드시 괄호안에 작성해야 한다.
        서브쿼리에는 ORDER BY 절을 사용할 수 없다.
*/




/*
--서브쿼리(sub query)
*/

SELECT EMPNO,ENAME
FROM EMP
WHERE SAL > (SELECT SAL
              FROM EMP
              WHERE ENAME = 'SCOTT');
/*
   A.서브쿼리 위치에 따른 종류
      ? SELECT 절 ☞ 스칼라 서브쿼리
      ? FROM 절 ☞ ★★★인라인 뷰★★★ 무한 확장이 가능
      ? WHERE 절 ☞ Nested 서브쿼리, 스칼라 서브쿼리
      ? GROUP BY 절 ☞ 스칼라 서브쿼리
      ? HAVING 절 ☞ 스칼라 서브쿼리
      ? ORDER BY 절 ☞ 스칼라 서브쿼리
      
  B.스칼라 서브쿼리(scalar subquery)
  
      1.스칼라 서브쿼리(scalar subquery)
        - 하나의 SQL문으로 취급되지만 본질적으로 하나의 함수로 간주하면됨
        - 함수의 가장큰특징은 많은 INPUT 이 있더라도 OUTPUT은 하나만 나온다는것입니다.
        - 스칼라 서브쿼리도 일종의 함수이므로 중첩해서 사용가능하나 
          OUTPUT이 두개 이상이거나,OUTPUT의 데이타타입이 맞지않는 경우에는 에러를 발생시킵니다.
        - 대량의 데이타처리시 스칼라쿼리의 남발은 성능저하를 유발할수있으므로
          조인으로 대체하는것이 좋습니다. 
      2.스칼라 서브쿼리(scalar subquery)위치
        - SELECT LIST 항목
        - 함수의 인자
        - WHERE절의 조건
        - ORDER BY 절
        - CASE 조건절
        - CASE 결과절
      3.대량의 데이타 처리시 개별적인건마다 수행되는 스칼라서브쿼리를 남발하는경우는
        대량의 데이타를 한꺼번에 처리할수있는 집합적개념이나 조인의 장점을 작용하기 
        힘들기 때문에 가능하면 스칼라서브쿼리가아니라 조인으로 대체하는것이 좋습니다.
 
  C.INLINE VIEW (subquery)   
   1. INLINE VIEW 필요성
     ?질의문의 FROM 절에 테이블만 사용 가능하다면 많은 임시 테이블을 만들어야 할 것입니다.
         다행히도 데이터베이스에서는 뷰라는 객체를 제공하여 이러한 테이블의 서브 집합을 
         질의문의 형태로 표현하여 저장할 수 있도록 하고 있습니다. 
         그러나, 뷰 또한 데이터베이스에 저장되는 객체이기 때문에 
         그 수가 많아지면 관리하기가 어렵습니다.
    ?이러한 단점을 극복할 수 있도록 오라클에서는 7 버젼부터 
        질의문의 FROM 절 자체에 서브쿼리를 사용할 수 있는 기능을 제공합니다. 
        그 서브쿼리를 인라인 뷰라고 부르며 질의문의 단순화 및 성능 향상 효과를 얻을 수 있습니다.
    ?인라인 뷰는 테이블과 뷰처럼 데이터베이스에 저장되는 객체가 아니고,
        질의문에서 뷰처럼 사용되는 별칭(Alias)을 가진 서브쿼리입니다. 
        서브쿼리 중에서도 FROM 절에 사용된 것을 나타내는 것으로써 
        WHERE 절에 사용되는 것을 나타내는 Nested 서브쿼리의 255 레벨 제한과는 다르게
        Top-Level 질의문에 대하여 그 레벨 제한이 없습니다. 
        뷰와 성격이 유사하며 임시로 만들어진 다음에 없어진다는 특징이 있습니다.
        
  2.INLINE VIEW 특징
    ?SELECT 문의 FROM 절에 Subquery를 사용할 수 있는데 사용 방법은 VIEW와 유사하며, 
        특별히 INLINE VIEW라고 칭합니다.
    ?SELECT문의 FROM절에 있는 Subquery 는 특정 SELECT 문에 대한 데이터 소스를 정의하며 
        해당 SELECT 문에 대해서만 정의합니다.
    ?NLINE VIEW 는 SQL문장 내에서만 유효한 Temporary VIEW 이므로,
        VIEW 와는 달리 Database Object 가 아닙니다.
    ?즉, INLINE VIEW 는 Subquery 형식을 이용한 임시 뷰라고 할 수 있습니다.
    ?SQL문 활용이.....  `ㅈ먼저 수행되기 때문에 
        Non Procedural 언어인 SQL에 절차적인 기능을 부여한 아주 유용한 기능입니다.
  3.INLINE VIEW의 활용 
      - 조인 회수의 감소
      - 절차성을 위한 인라인 뷰의 활용
        
 */
 
-- 스칼라 서브쿼리
-- 1. SELECT COL              
SELECT EMPNO, ENAME, SAL, 
        (SELECT GRADE FROM SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL) GRADE
FROM EMP;

SELECT EMPNO, ENAME,
        (SELECT DNAME FROM DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO) 부서이름,
        (SELECT LOC FROM DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO) 부서위치
FROM EMP;


-- 2. 함수의 인자
SELECT EMPNO, ENAME, 
      INITCAP((SELECT DNAME FROM DEPT d WHERE d.DEPTNO = e.DEPTNO)) as DNAME
FROM EMP e;

-- 3. WHERE절의 조건
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
              
              
-- 복수행 연산자 (IN, ANY, ALL)


  -- IN
  --부서별 최소 임금들 (950, 800, 1300)
SELECT DEPTNO, MIN(SAL)
FROM EMP
GROUP BY DEPTNO;


  --부서별 최소 임금을 받는 사원의 정보 출력
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN (
            (SELECT MIN(SAL)
            FROM EMP
            GROUP BY DEPTNO) -- 950, 800, 1300
            );               -- 서브쿼리는 반드시 괄호!


SELECT *
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                FROM EMP
                WHERE ENAME='SCOTT');
                

  -- ALL
  -- 사원 테이블에서 업무가 MANAGER인 사원의 급여들보다 적은 급여를 갖는 직원
SELECT SAL FROM EMP WHERE JOB='MANAGER'; -- 2975, 2850, 2450

SELECT *
FROM EMP
WHERE SAL < ALL (2975, 2850, 2450); -- 다중 데이터 모두가 만족하는 데이터를 찾음

SELECT *
FROM EMP
WHERE SAL < ALL(SELECT SAL FROM EMP WHERE JOB='MANAGER');



  -- ANY
  -- MANAGER의 급여보다 많은 급여를 받는 사원들의 이름을 검색
SELECT SAL FROM EMP WHERE JOB='MANAGER'; -- 2975, 2850, 2450

SELECT *
FROM EMP
WHERE SAL > ANY(2975, 2850, 2450);  --2450 보다 크면 만족

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
    실습문제
*/

-- 1. 사원 테이블에서 BLAKE 보다 급여가 맣ㄴ은 사원들의 사번 이름 급여를 검색
SELECT e.EMPNO, e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL > (
                SELECT SAL
                FROM EMP
                WHERE ENAME LIKE 'BLAKE'
              );
              


-- 2. 사원 테이블에서 MILLER 보다 늦게 입사한 사원의 사번 이름 입사일 검색
SELECT e.EMPNO, e.ENAME, TO_CHAR(e.HIREDATE, 'DD') 입사일
FROM EMP e
WHERE TO_NUMBER(TO_CHAR(e.HIREDATE, 'DD')) > (
              SELECT TO_NUMBER(TO_CHAR(e.HIREDATE, 'DD'))
                FROM EMP e
                WHERE ENAME LIKE 'MILLER'
              );

 SELECT TO_NUMBER(TO_CHAR(e.HIREDATE, 'DD'))
                FROM EMP e
                WHERE ENAME LIKE 'MILLER';

-- 3. 사원 테이블에서 사원 전체 평균 급여보다 급여가 많은 사원들의 사번, 이름, 급여를 검색
SELECT e.EMPNO, e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL > (
              SELECT AVG(e.SAL)
                FROM EMP e
              );
              
              SELECT AVG(e.SAL)
                FROM EMP e;


-- 4. 사원 테이블에서 CLARK와 같은 부서이며, 사번이 7698인 직원의 급여보다 많은 급여를 받는 사원들의
--     사원들의 사번, 이름, 급여를 검색
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


-- 5. 사원 테이블에서 부서별 최대 급여를 받는 사원들의 사번, 이름, 부서코드, 급여를 검색
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
                



