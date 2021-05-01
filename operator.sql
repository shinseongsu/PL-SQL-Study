set serveroutput on;

-- 연산자(operator)는 피연산자(operand)에 대한 연산을 수행한다.

-- PL/SQL의 연산자는 아래와 같이 구분된다.
-- 비교, 논리 연산자는 불리언 값을 반환한다.

-- 산술 연산자
-- 산술 연산자(arithmetic operator)는 숫자, 날짜 값에 대한 산술 연산을 수행한다.

-- 두 표현식은 결과가 동일하지만 두 번째 표현식처럼 괄호를 사용하는 편이 가독성 측면에서 바람직하다.

BEGIN
    DBMS_OUTPUT.PUT_LINE(1 + 2 - 3 * 4 / 5);
    DBMS_OUTPUT.PUT_LINE(1 + 2 - ((3 * 4) / 5));
END;

/*

.6
.6
*/

BEGIN
    DBMS_OUTPUT.PUT_LINE(2 ** 10);
    DBMS_OUTPUT.PUT_LINE(POWER (2, 10));
END;

/*
1024
1024

*/


-- 나눗셈의 계수가 0이면 에러가 발생한다.
BEGIN
    DBMS_OUTPUT.PUT_LINE(1 / 0);
END;
-- divisor is equal to zero


-- 날짜 연산에서 숫자 값은 일수로 계산된다. 세 번째 표현식처럼 숫자 값보다 인터벌 값을 사용하는 편이 가독성 측면에서 바람직하다.
BEGIN
    DBMS_OUTPUT.PUT_LINE(DATE '2050-01-01' - 1);
    DBMS_OUTPUT.PUT_LINE(DATE '2050-01-01' + 1 / 24 / 60 / 60);
    DBMS_OUTPUT.PUT_LINE(DATE '2050-01-01' + INTERVAL '1' SECOND);
END;

/*
49/12/31
50/01/01
50/01/01
*/

-- TIMESTAMP 값에 대한 산술 연산을 수행한다.
-- TIMESTAMP 값에 숫자 값을 연산하면 암시적 데이터변환이 발생한다.
-- TIMESTAMP 값이 DATE 값으로 변환되어 소수점 이하 초가 유실된다.

BEGIN
    DBMS_OUTPUT.PUT_LINE(TIMESTAMP '2050-01-01 23:59:59.999999999' + 1);
    DBMS_OUTPUT.PUT_LINE(TIMESTAMP '2050-01-01 23:59:59.999999999' + INTERVAL '1' DAY);
END;

/*
50/01/02
50/01/02 23:59:59.999999999
*/

-- DATE 값의 산술 연산은 일수를 나타내는 숫자 값, TIMESTAMP 값의 산술 연산은 인터벌 값을 반환한다.
-- INTERVAL 값의 산술 연산은 인터벌 값을 반환한다.

BEGIN
    DBMS_OUTPUT.PUT_LINE(DATE '2050-01-02' - DATE '2050-01-01');
    DBMS_OUTPUT.PUT_LINE(TIMESTAMP '2050-01-02 00:00:00'
                       - TIMESTAMP '2050-01-01 00:00:00');
    DBMS_OUTPUT.PUT_LINE(INTERVAL '2' DAY - INTERVAL '1' DAY);                   
END;

/*
1
+000000001 00:00:00.000000000
+000000001 00:00:00.000000000
*/


-- 산술 연산의 피연산자가 널이면 결과도 널이다.

BEGIN
    DBMS_OUTPUT.PUT_LINE('1: ' || (1 + NULL));
    DBMS_OUTPUT.PUT_LINE('2: ' || (DATE '2050-01-01' + NULL));
    DBMS_OUTPUT.PUT_LINE('3: ' || (TIMESTAMP '2050-01-01 00:00:00' + NULL));
END;

/*
1: 
2: 
3: 
*/


-- 결합연산자
-- 연결 연산자(concatenation operator)는 피연산자를 연결한 문자 값을 반환한다.
-- 문자 값이 아닌 피연산자는 암시적 데이터 변환에 의해 문자 값으로 반환된다.

BEGIN
    DBMS_OUTPUT.PUT_LINE('A' || NULL || 1);
END;

-- A1


-- 비교 연산자
/*
    비교 연산자는 표현식을 비교한다.
    결과는 참, 거짓, 널이다. 비교 연산자가 널이면 결과도 널이다.
*/

-- 관계 연산자
-- 관계 연산자는 표현식의 관계를 비교한다.

BEGIN
    prc_boolean(1 < 2);
    prc_boolean(1 > 2);
    prc_boolean(1 < NULL);
END;

/*
    T
    F
    N
*/

-- BETWEEN 연산자
-- BETWEEN 연산자는 expr1 표현식이 expr2 ~ expr3의 범위에 속하는지 비교한다.

BEGIN
    prc_boolean(2 BETWEEN 1 AND 3);
    prc_boolean(2 NOT BETWEEN 1 AND 3);
END;

/*
    T
    F
*/


-- IN 연산자
-- IN 연산자는 expr1 표현식이 expr2 [, expr2] 목록에 포함되는지 비교한다.

BEGIN
    prc_boolean(1 IN (1, 2));
    prc_boolean(1 NOT IN (1, 2));
END;

/*
    T
    F
*/


-- LIKE 연산자
-- LIKE 연산자는 char1 문자 값이 char2 패턴과 일치하는지 비교한다.

BEGIN
    prc_boolean('ABC' LIKE 'A%');
    prc_boolean('ABC' LIKE '%B');
    prc_boolean('ABC' LIKE '_B_');
    prc_boolean('ABC' NOT LIKE 'A%');
END;

/*
    T
    F
    T
    F
*/


-- 특수 문자(%, _)를 비교할 경우 ESCAPE 문자를 사용할 수 있다.

BEGIN
    prc_boolean('A%C' LIKE '_\%_' ESCAPE '\');
    prc_boolean('ABC' LIKE '_\%_' ESCAPE '\');
END;

/*
    T
    F
*/


-- 널 연산자
-- 널 연산자는 expr 표현식이 널인지 검사한다.

BEGIN
    prc_boolean('' IS NULL);
    prc_boolean('' IS NOT NULL);
END;

/*
    T
    F
*/


-- 논리 연산자
-- 논리 연산자는 피연산자에 대한 논리 연산을 수행한다. AND, OR, NOT 연산자를 사용할 수 있다.

BEGIN
    prc_boolean(TRUE AND FALSE);
    prc_boolean(TRUE OR FALSE);
    prc_boolean(NOT TRUE);
END;

/*
    F
    T
    F
*/

-- 단락 평가

-- PL/SQL은 논리 표현식을 단락 평가(short-circuit evaluation)한다.
-- AND 조건은 FALSE, OR 조건은 TRUE인 피연산자가 평가되면 이후 피연산자를 평가하지 않는다.
-- 단락 평가로 인해 예상치 못한 에러가 발생할 수 있으므로 주의가 필요하다.

-- 1)

DECLARE
    v1 NUMBER := 0;
BEGIN
    IF ( v1 != 0 AND (10 / v1) > 1) THEN
        NULL;
    END IF;
END;

-- PL/SQL 프로시저가 성공적으로 완료되었습니다.


-- 2)

DECLARE
    v1 NUMBER := 0;
BEGIN
    IF ((10 / v1) > 1 AND v1 != 0) THEN
        NULL;
    END IF;
END;

-- divisor is equal to zero


-- AND 조건은 FLASE, OR 조건은 TRUE 피연산자를 먼저 기술하는 편이 성능 측면에서 효울적이다.

-- 1)

DECLARE
    v1 NUMBER := 1;
BEGIN
    IF (v1 BETWEEN 10 AND 100 OR v1 = 1)
    THEN
        NULL;
    END IF;
END;

-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 2)

DECLARE
    v1 NUMBER := 1;
BEGIN
    IF (v1 = 1 OR v1 BETWEEN 10 AND 100)
    THEN
        NULL;
    END IF;
END;

-- PL/SQL 프로시저가 성공적으로 완료되었습니다.


-- 연산자 우선순위
-- 연산자는 아래의 연산자 우선순위에 따라 평가된다. 동일한 우선순위의 연산자는 기술 순서대로 평가된다.

BEGIN
    DBMS_OUTPUT.PUT_LINE(1 + 2 || 'X');
END;
-- 3X

BEGIN
    DBMS_OUTPUT.PUT_LINE('X' || 1+ 2);
END;
-- character to number conversion error


-- 표현식에 괄호를 사용하면 예상치 못한 에러를 방지할 수 있다.
-- 아래 쿼리는 괄호로 연산 순서를 조정했다.

BEGIN
    DBMS_OUTPUT.PUT_LINE('X' || (1 + 2));
END;
-- X3


-- SQL 함수
-- 대부분의 단일 행 SQL 함수를 PL/SQL 표현식으로 사용할 수 있다.
-- DECODE, DUMP 함수 등의 인코딩 디코딩 함수와 BIN_TO_NUM, LNNVL, NVL2, WIDTH_BUCKET 함수는 PL/SQL 표현식으로 사용할 수 없다.

BEGIN
    DBMS_OUTPUT.PUT_LINE( TO_CHAR( SYSDATE, 'YYYYMMDD' ));
END;
-- 20210501

-- DECODE 함수를 PL/SQL 표현식으로 사용하면 에러가 발생한다.
BEGIN
    DBMS_OUTPUT.PUT_LINE(DECODE(1, 1, 1, 2));
END;
-- function or pseudo-column 'DECODE' may be used inside a SQL statement only


-- DECODE 함수 대신 CASE 표현식을 사용할 수 있다.
BEGIN
    DBMS_OUTPUT.PUT_LINE(CASE WHEN 1 = 1 THEN 1 ELSE 2 END);
END;
-- 1

-- PL/SQL 표현식으로 사용할 수 없는 함수는  SELECT INTO 문으로 사용할 수 있다.
DECLARE
    v1 DATE := DATE '2050-01-01';
    v2 VARCHAR2(4000);
BEGIN
    SELECT DUMP(v1) INTO v2 FROM DUAL;
    DBMS_OUTPUT.PUT_LINE(v2);
END;
-- Typ=12 Len=7: 120,150,1,1,1,1,1


-- 11.1 버전부터 시퀀스를 PL/SQL 표현식으로 사용할 수 있다.

DROP SEQUENCE s1;
CREATE SEQUENCE s1;

BEGIN
    DBMS_OUTPUT.PUT_LINE(s1.NEXTVAL);
END;
-- 1

-- 10.2 이하 버전은 SELECT INTO 절을 사용해야 한다.
DECLARE
    v1 NUMBER;
BEGIN
    SELECT s1.NEXTVAL INTO v1 FROM DUAL;
    DBMS_OUTPUT.PUT_LINE(v1);
END;
-- 2