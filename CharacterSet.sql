set serveroutput on;

-- 캐릭터 셋

-- 캐릭터 셋(character set)은 캐릭터 코드의 집합이다.
-- PL/SQL 코드와 데이터는 캐릭터 코드로 표현된다.



-- 식별자
-- 식별자(idntifier)는 PL/SQL 요소의 이름이다. PL/SQL은 식별자의 대소자문자를 구별하지 않는다.

DECLARE
    v1 NUMBER;
BEGIN
    NULL;
END;


-- 사용자 정의 식별자
-- 사용자 정의 식별자(user-defined identifier)는 사용자가 정의한 식별자이다.
-- 데이터베이스 캐릭터 셋을 기준으로 12.1 이하 버전은 30바이트, 12.2 이상 버전은 128바이트의 식별자를 정의할 수 있다.
-- 사용자 정의 식별자는 일반 사용자 정의 식별자와 인용 사용자 정의 식별자로 구분된다.


DECLARE
    v1 NUMBER;
BEGIN
    NULL;
END;

-- 아래 예제는 숫자로 시작한 일반 사용자 정의 식별자(1v)를 사용하여 에러가 발생한다.

DECLARE
    1v NUMBER;
BEGIN
    NULL;
END;

-- 에러 메시지 : Encountered the symbol "1" when expecting one of the following



-- 인용 사용자 정의 식별자

-- 인용 사용자 정의 식별자(quoted user-defined identifier)는 식별자를 큰 따옴표(")로 감싸서 기술한다.
-- 문자로 시작하지 않아도 되며 큰 따옴표, 개행 문자, 널 문자를 제회한 모든 문자를 포함할 수 있다.
-- 일반 사용자 정의 식별자와 달리 대소문자를 구분한다.


DECLARE
    "1v" NUMBER;
BEGIN
    NULL;
END;

DECLARE
    "v1" NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v1);
END;

-- identifier 'V1' must be declared


-- "v1" 인용 사용자 정의 식별자를 사용하면 에러가 발생하지 않습니다.
-- 직전 예제처럼 사용자 정의 식별자로 인해 예상치 못한 에러가 발생할 수 있다.
-- 특별한 경우가 아니라면 사용하지 않는 편이 바람직하다.


DECLARE
    "v1" NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE("v1");
END;


-- 리터럴
-- 리터럴(literal)은 변하지 않는 값이다.
-- PL/SQL은 SQL처럼 문자, 숫자, 날짜, 인터벌 리터럴을 사용할 수 있고 추가로 불리언 리터럴을 사용할 수 있다.

-- 문자 리터럴
-- 문자 리터럴은 문자 값을 지정한다.
-- 문자 값을 작은 따옴표(')로 감싸서 기술한다.
-- ''는 CHAR 타입의 널로 처리된다.

BEGIN
    DBMS_OUTPUT.PUT_LINE('1|A');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('2''B');
END;

/*
result
---------------

1|A
 
2'B
*/


-- 10.1 버전부터 인용 방식의 문자 리터럴을 사용할 수 있다.
-- 인용 구분자(quote delimiter)는 [], {}, <>, () 등을 사용할 수 있다.

BEGIN
    DBMS_OUTPUT.PUT_LINE(q'[2'B']');
    DBMS_OUTPUT.PUT_LINE(q'{[3C]}');
END;

/*
result
-----------

2'B'
[3C]
*/


-- 숫자 리터럴
-- 숫자 리터럴은 숫자 값을 지정한다.
-- e는 과학적 표기법을 나타낸다.

BEGIN
    DBMS_OUTPUT.PUT_LINE(1);
    DBMS_OUTPUT.PUT_LINE(-2);
    DBMS_OUTPUT.PUT_LINE(3.4);
    DBMS_OUTPUT.PUT_LINE(1.2e2);
    DBMS_OUTPUT.PUT_LINE(-3.4e-2);
END;

/* 
result
-------------

1
-2
3.4
120
-.034       
*/


-- BINARY_FLOAT, BINARY_DOUBLE 타입의 숫자 리터럴은 각각 F와 D를 접미어로 사용한다.

BEGIN
    DBMS_OUTPUT.PUT_LINE(1.2F);
    DBMS_OUTPUT.PUT_LINE(-3.4D);
END;

/*
result
----------

1.20000005E+000
-3.3999999999999999E+000
*/


-- 날짜 리터럴
-- 날짜 리터럴은 날짜 값을 지정한다.
-- DATE, TIMESTAMP, TIMESTAMP WITH TIME ZONE 리터럴을 사용할 수 있다.

BEGIN
    DBMS_OUTPUT.PUT_LINE(DATE '2050-01-01');
    DBMS_OUTPUT.PUT_LINE(TO_DATE('2050-01-01 23:59:59', 'YYYY-MM-DD HH24:MI:SS'));
END;

/*
result
------------

50/01/01
50/01/01
*/


-- 아래는 TIMESTAMP, TIMESTAMP WITH TIME ZONE 리터럴을 사용한 예제이다.
-- TIMESTAMP 리터럴은 소수점 이하 초, TIMESTAMP WITH TIME ZONE 리터럴은 TIMESTAMP에 시간대 변위 값을 포함시킬 수 있다.

BEGIN
    DBMS_OUTPUT.PUT_LINE(TIMESTAMP '2050-01-01 23:59:59.99999999');
    DBMS_OUTPUT.PUT_LINE(TIMESTAMP '2050-01-01 23:59:59.99999999 +09:00');
END;


/*
result
------------

50/01/01 23:59:59.999999990
50/01/01 23:59:59.999999990 +09:00
*/


-- 인터벌 리터럴
-- 인터벌 리터럴은 시간의 간격을 지정한다.

BEGIN
    DBMS_OUTPUT.PUT_LINE(INTERVAL '99' YEAR);
    DBMS_OUTPUT.PUT_LINE(INTERVAL '99' MONTH);
    DBMS_OUTPUT.PUT_LINE(INTERVAL '99-11' YEAR TO MONTH);
END;

/*
result
--------------

+000000099-00
+000000008-03
+000000099-11
*/