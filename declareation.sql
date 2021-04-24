-- 변수(variable)는 값을 변경할 수 있는 식별자이다.
-- 식별자로 값을 할당하거나 참조할 수 있다.
-- 초기 값을 지정하지 않은 변수는 항상 널로 초기화 된다.

-- 숫자 타입 변수는 가급적 0으로 초기화하는 편이 바람직하다.
-- NOT NULL 제약조건을 추가할 수 도 있다.

set serveroutput on;

DECLARE
    v1 NUMBER;
    v2 NUMBER := 0;
    v3 NUMBER NOT NULL := v2 + 1;
BEGIN
    v1 := v1 + 1;
    DBMS_OUTPUT.PUT_LINE('V1: ' || v1);
    DBMS_OUTPUT.PUT_LINE('V2: ' || v2);
    DBMS_OUTPUT.PUT_LINE('V3: ' || v3);
END;



/*
result
---------------


V1: 
V2: 0
V3: 1
*/


-- 변수와 변수에 할당한 값은 데이터 타입이 동일해야 한다.
-- 데이터 타입이 동일 하지 않으면 암시적 데이터 변환이 발생하고 데이터 변환이 실패하면 에러가 발생한다.

DECLARE
    v1 NUMBER;
BEGIN
    v1 := 'A';
END;

-- 타입 에러

DECLARE
    v1 NUMBER NOT NULL;
BEGIN
    NULL;
END;

-- 초기치를 할당하지 않았습니다.

DECLARE
    v1 NUMBER NOT NULL := 1;
BEGIN
    v1 := NULL;
END;

-- 식이 잘못된 유형입니다.



-- 상수
-- 상수(constant)는 값을 변경할 수 없는 식별자다.
-- 식별자로 값을 참조할 수 만 있다.


DECLARE
    c1 CONSTANT NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE(c1);
END;

/*
result
-------------

1
*/


-- 상수는 반드시 초기값을 할당해야 한다.

DECLARE
    c1 CONSTANT NUMBER;
BEGIN
    NULL;
END;

-- 에러


-- 상수에 값을 할당해도 에러가 발생한다.

DECLARE
    c1 CONSTANT NUMBER := 1;
BEGIN
    C1 := 1;
END;

-- 에러


-- 상수는 컴파일 시점이 값이 정해지므로 리터럴처럼 사용할 수 있다.
-- 변수 선언에 변수 값을 사용하면 에러가 발생한다.
DECLARE
    c1 CONSTANT NUMBER := 10;
    v2 NUMBER := c1;
BEGIN
    NULL;
END;


-- %TYPE 속성
-- %TYPE 속성을 사용하면 변수와 테이블 칼럼의 데이터 타입으로 변수와 상수를 선언할 수 있다.
-- 참조하는 변수와 테이블 칼럼의 데이터 타입을 변경하면 TYPE 속성을 사용한 변수와 상수의 데이터 타입도 함께 변경된다.

DECLARE
    v1 dept.deptno%TYPE;
    v2 v1%TYPE;
BEGIN
    NULL;
END;


-- 테이블 칼럼에 대한 %TYPE 속성은 NOT NULL 제약조건이 상속되지 않는다.
-- 아울러 변수와 테이블 칼럼 모두 초기값과 기본값이 상속되지 않는다.

DECLARE
    v1 dept.deptno%TYPE;
BEGIN
    v1 := NULL;
END;



-- 범위
-- 범위(scope)은 식별자를 참조할 수 있는 PL/SQL 블록의 영역이다.
-- 변수는 선언한 블록에서 지역(local) 변수, 선언한 블록의 중첩 블록에서 전역(global) 변수로 동작한다.

DECLARE
    v1 NUMBER := 1;
BEGIN
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v1);
    END;
END;


/*
result
----------------

1
*/


-- 내부 블록의 실행이 종료되면 내부 블록에서 선언한 v1 변수이 해제되어 외부 블록에서 v1 변수를 참조할 수 없다.

BEGIN
    DECLARE
        v1 NUMBER := 1;
    BEGIN
        NULL;
    END;
    
    DBMS_OUTPUT.PUT_LINE(v1);
END;

-- V1 식별자가 정의되어야 합니다.



-- 가시성
-- 가시성(visibility)은 식별자를 한정(gualified) 하지 않고 참조할 수 있는 PL/SQL 블록의 영역이다.
-- 외부 블록과 내부 블록에 이름이 동일한 식별자를 선언하면 내부 블록에서 외부 블록의 식별자를 참조할 수 없다.
-- 내부블록에서 이름이 동일한 외부 블록의 식별자를 참조하려면 레이블이나 서브프로그램명으로 내부 블록의 식별자를 한정해야 한다.

DECLARE
    v1 NUMBER := 1;
BEGIN
    DECLARE
        v1 NUMBER := 2;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v1);
    END;
    
    DBMS_OUTPUT.PUT_LINE(v1);
END;


/*
result
--------------

2
1
*/


-- 코드의 모호함을 방지하기 위해 블록 전체에 고유한 식별자를 사용하는 편이 바람직하다.

<<outer>>
DECLARE
    v1 NUMBER := 1;
BEGIN
    <<inner>>
    DECLARE
        v1 NUMBER := 2;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v1);
        DBMS_OUTPUT.PUT_LINE(inner.v1);
        DBMS_OUTPUT.PUT_LINE(outer.v1);
    END;
END;

/*
result
------------------

2
2
1
*/