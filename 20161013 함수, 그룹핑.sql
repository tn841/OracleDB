/*
<<SELECT 문장 실행순서>>
  5.SELECT 칼럼 or 표현식
  1.FROM 테이블명
  2.WHERE 조건식
  3.GROUP BY 컬럼 or 표현식
  4.HAVING 그룹조건식
  6.ORDER BY 컬럼 or 표현식 //별칭을 쓸 수 있다.
*/

/*
GROUP BY 작성 지침
 SELECT 절 뒤에 사용할 수 있는 컬럼은 GROUP BY 뒤에 기술된 컬럼 또는 그룹함수가 적용된 컬럼 이어야 한다.
 WHERE 절을 사용하여 행을 그룹으로 분류하기 전에 제외 시킬 수 있다.
 GROUP BY 절 뒤에는 컬럼 별칭을 사용할 수 없다.
*/

--부서별 급여 합계, 급여평균, 사원수
SELECT deptno, sum(sal) 급여합, round(avg(sal)) 급여평균, count(*) 사원수--group by 된 컬럼 또는 그룹함수가 적용된 컬럼
FROM EMP
Group BY DEPTNO;

--개인 급여가 800이상이면서 부서별 급여합이 9000이상인 부서(그룹)만 출력
select deptno 부서번호, sum(sal) 급여합계
from emp
where sal>800
group by deptno
having sum(sal) > 9000
ORDER BY 부서번호 ASC;

-- 부서별, 직급별 급여합, 급여평균
select deptno, job, empno, sum(sal) 급여합, avg(sal) 급여평균
from emp
group by deptno, job, empno
order by deptno;


--가로출력 -> decode나 case함수 사용
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

--전체사원의 직급별  급여합계
SELECT
       SUM(DECODE(JOB,'CLERK',SAL)) AS "CLERK",
       SUM(DECODE(JOB,'MANAGER',SAL)) AS "MANAGER",
       SUM(DECODE(JOB,'PRESIDENT',SAL)) AS "PRESIDENT",
       SUM(DECODE(JOB,'ANALYST',SAL)) AS "ANALYST",
       SUM(DECODE(JOB,'SALESMAN',SAL)) AS "SALESMAN"
FROM EMP;



--실습 문제
-- 1. 사원테이블에서 부서별 인원수가 6명 이상인 부서코드 검색?
select deptno, count(*) 인원수
from emp
group by deptno
having count(*) >= 6;


-- 2. 사원테이블로부터 부서번호, 업무별 급여합계를 계산하고자한다. 
--    다음과 같은 결과를 출력할 수 있는 SQL문은?

select DEPTNO,
        SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
        SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
        SUM(DECODE(job, 'PRESIDENT', sal)) as "PRESIDENT",
        SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
        SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
from emp
GROUP BY DEPTNO
ORDER BY DEPTNO;



-- 3. 사원테이블로부터 년도별 , 월별 급여합계를 출력할 수 있는SQL문
SELECT EXTRACT(YEAR FROM HIREDATE)AS "년",
       EXTRACT(month FROM HIREDATE) AS "월",
       SUM(SAL) 
FROM EMP
GROUP BY HIREDATE
ORDER BY "년", "월";


-- 4. 사원테이블에서 부서별 comm(커미션) 을 포함하지 않은 연봉의 합과 
--    포함한 연봉의 합을 구하는 SQL을 작성하시오.
select deptno, sum(sal) 연봉
from emp
group by deptno;

select deptno, sum(sal+nvl(comm,0)) 연봉
from emp
group by deptno;



-- 5. 사원테이블에서 SALESMAN을 제외한 JOB별 급여합계?
SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING JOB not like 'SALESMAN';


