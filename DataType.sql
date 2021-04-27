set serveroutput on;
-- VARCHAR2 타입

-- 가변 길이 문자 타입이다.
-- size는 1 ~ 32,767의 범위를 가진다.

DECLARE
    v1 VARCHAR2(1);
BEGIN
    v1 := '가';
END;

-- 수치 또는 값 오류: 문자열 버퍼가 너무 작습니다.

DECLARE
    v1 VARCHAR2(1 CHAR);
BEGIN
    v1 := '가';
END;


-- CHAR 타입

-- CHAR 타입은 고정 길이 문자 타입이다.
-- size의 범위는 1 ~ 32,767  기본값은 1이다.
-- CHAR 타입과 VARCHAR2 타입을 혼용하지 말고 VARCHAR2 타입만 사용하는 편이 바람직하다.

DECLARE
    v1 CHAR(2)     := 'A';
    v2 VARCHAR(2)  := 'A';
BEGIN
    DBMS_OUTPUT.PUT_LINE(v1 || 'X');
    DBMS_OUTPUT.PUT_LINE(v2 || 'X');
    prc_boolean(v1 = v2);
END;


/*
result
---------------


A X
AX
F
*/

-- LONG 타입
/*
    LONG 타입은 가변 길이 문자 타입이다.
    최대 32,760바이트의 문자 값을 저장한다.
    LONG 타입은 하위 호환성을 위해 유지되고 있으므로 사용하지 않는 편이 바람직하다.
*/


-- CLOB 타입
/*
    CLOB 타입은 가변 길이 문자 타입이다.
    CLOB은 Character Large OBject의 약어다.
    최대 128TB의 문자 값을 저장한다.
*/


DECLARE
    v1 VARCHAR2(32767) := LPAD(TO_CLOB('X'), 32768, 'X');
BEGIN
    NULL;
END;

-- 수치 오류 ( 32,767 바이트보다 큰 문자 값은 CLOB 타입에 저장해야 한다. )

DECLARE
    v1 CLOB := LPAD(TO_CLOB('X'), 32768, 'X');
BEGIN
    NULL;
END;


-- 숫자 타입
/*
    숫자 타입은 정수와 실수 값을 저장한다.
    NUMBER, BINARY_FLOAT, BINARY_DOUBLE 타입과 다수의 숫자 서브타입을 사용할 수 있다.
*/


-- NUMBER 타입
/*
    NUMBER 타입은 정밀도(q)와 스케줄(s)의 숫자 값을 저장한다.
    정밀도는 1 ~ 38, 스케줄은 -84 ~ 127의 범위를 가진다.
    크기에 따라 1 ~ 22 바이트의 저장 공간을 사용한다.
*/

-- BINARY_FLOAT 타입
/*
    BINARY_FLOAT 타입은 IEEE 745 방식의 32비트 부동 소수점 수를 저장한다.
    4바이트의 저장 공간을 사용한다.
*/

-- BINARY_DOUBLE 타입
/*
    BINARY_DOUBLE 타입은 IEEE 745 방식의 64비트 부동 소수점 수를 저장한다.
    8바이트의 저장 공간을 사용한다.
    
    BINARY_FLOAT, BINARY_DOUBLE 타입은 NUMBER 타입보다 정확도가 낮지만 연산 속도가 빠르다.
*/

SET TIMING ON

DECLARE
    v1 NUMBER := 2;
    v2 NUMBER := 2 / 3;
BEGIN
    FOR i IN 1 .. 1e6 LOOP
        v1 := POWER(v1, v2);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(v1);
END;

-- 1.00000000000000000000000000000000000001


-- 숫자 서브타입
/*
    숫자 서브타입은 STANDARD 패키지에 선언되어 있다.
    아래는 BINARY_INTEGER 서브타입의 선언이다.
    서브타입에 대한 내용은 조금 후에 살펴보자.
    
    BINARY_INTEGER 타입은 NUMBER 타입보다 작은 저장 공간을 사용하고 연산속도가 빠르다.
*/


DECLARE
    v1 BINARY_INTEGER := 2147483647;
BEGIN
    DBMS_OUTPUT.PUT_LINE( v1 + 1);
END;

-- overflow 발생

/*
    BINARY_INTEGER 타입의 서브타입이다.
    BINARY_INTEGER 타입과 PLS_INTEGER 타입은 동일한 데이터 타입이다.
    네이티브 컴파일인 경우 SIMPLE_* 타입은 BINARY_* 타입보다 연산속도가 빠르다.
*/

DECLARE
    v1 SIMPLE_INTEGER := 2147483647;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v1 + 1);
END;

-- -2147483648


-- 날짜 타입
/*
    날짜 타입은 날짜(datetime)와 기간(interval) 값을 저장한다.
    DATE, TIMESTAMP, INTERVAL 타입과 TIMESTAMP, INTERVAL 타입의 서브타입을 사용할 수 있다.
*/

-- DATE 타입
/*
    DATE 타입은 고정 길이 날짜 타입이다.
    7바이트의 저장공간을 사용한다.
*/

DECLARE
    v1 DATE := DATE '2050-01-01';
    v2 DATE := TO_DATE('2050-01-01 23:59:59', 'YYYY-MM-DD HH24:MI:SS');
BEGIN
    DBMS_OUTPUT.PUT_LINE(v1);
    DBMS_OUTPUT.PUT_LINE(v2);
END;

/*
   50/01/01
   50/01/01 
*/


-- TIMESTAMP 타입
/*
    TMESTAMP 타입은 가변 길이 날짜 타입이다.
    소수점 이하 초 단위 시간을 포함한 날짜 값을 저장한다.
*/

DECLARE
    v1 TIMESTAMP := TIMESTAMP '2050-01-01 09:00:00';
BEGIN
    DBMS_OUTPUT.PUT_LINE(v1);
END;

-- 50/01/01 09:00:00.000000


-- TIMESTAMP WITH TIME ZONE 타입
/*
    TIMESTAMP WITH TIME ZONE 타입은 시간대 변위 값을 포함한 TIMESTAMP 값을 저장한다.
    기본값은 6이다. 13바이트의 저장 공간을 사용한다.
*/

DECLARE
    v1 TIMESTAMP WITH TIME ZONE := TIMESTAMP '2050-01-01 09:00:00 +09:00';
BEGIN
    DBMS_OUTPUT.PUT_LINE(v1);
END;

-- 50/01/01 09:00:00.000000 +09:00


-- TIMESTAMP WITH LOCAL TIME ZONE 타입
/*
    TIMESTAMP WITH LOCAL TIME ZONE 타입은 시간대 변위 값을 데이터베이스 시간대로 변경한 TIMESTAMP 값을 저장한다.
    조회시 세션 시간대로 변환된 TIMESTAMP 값이 변환된다.
    정밀도에 따라 7 ~ 11 바이트의 저장 공간을 사용한다.
*/

EXEC DBMS_OUTPUT.PUT_LINE(SESSIONTIMEZONE);

-- Asia/Seoul


DECLARE
    v1 TIMESTAMP WITH LOCAL TIME ZONE := TIMESTAMP '2050-01-01 09:00:00 +09:00';
BEGIN
    DBMS_OUTPUT.PUT_LINE(v1);
END;

-- 50/01/01 09:00:00.000000



-- INTERVAL YEAR TO MONTH 타입
/*
    INTERVAL YEAR TO MONTH 타입은 연, 월 단위의 기간을 저장한다.
    5바이트의 저장공간을 사용한다.
*/

DECLARE 
    v1 INTERVAL YEAR TO MONTH := INTERVAL '99' YEAR;
    v2 INTERVAL YEAR TO MONTH := INTERVAL '99' MONTH;
    v3 INTERVAL YEAR TO MONTH := INTERVAL '99-11' YEAR TO MONTH;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v1);
    DBMS_OUTPUT.PUT_LINE(v2);
    DBMS_OUTPUT.PUT_LINE(v3);
END;

/*
    +99-00
    +08-03
    +99-11
*/