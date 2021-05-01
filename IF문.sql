set serveroutput on;

-- 조건문(conditional selection statement)은 불리언 표현식을 평가하여 결과가 TRUE인 표현식의 구문을 실행한다.

-- IF문
/*
    IF 문은 IF 절과 ELSIF 절의 불리언 표현식(boolean expression)을 기술 순서대로 평가하여 결과가 TRUE인 첫 번째 표현시의 구문을 실행한다.
    TURE인 표현식이 없으면 ELSE 절의 구문을 실행한다. IF THEN, IF THEN ELSE, IF THEN ELSIF의 세 가지 형식을 사용할 수 있다.
*/


VAR b1 NUMBER;

EXEC :b1 := 1  
BEGIN
    IF :b1 = 1 THEN
        DBMS_OUTPUT.PUT_LINE('A');
    END IF;    
END;
-- A

-- 아래는 IF THEN ELSE 형식을 사용한 예제이다.
-- 좌측 예제는 표현식이 UNKOWN 으로 평가되어 ELSE 절의 'B'가 반환된다.

VAR v1 NUMBER

EXEC :b1 := 1
BEGIN
    IF :b1 = 1 THEN
        DBMS_OUTPUT.PUT_LINE('A');
    ELSE
        DBMS_OUTPUT.PUT_LINE('B');
    END IF;
END;
-- A


-- 아래는 IF THEN ELSIF 형식을 사용한 예제다.

VAR b1 NUMBER

EXEC :b1 := 1
BEGIN
    IF :b1 = 1 THEN
        DBMS_OUTPUT.PUT_LINE('A');
    ELSIF :b1 = 2 THEN
        DBMS_OUTPUT.PUT_LINE('B');
    ELSE
        DBMS_OUTPUT.PUT_LINE('C');
    END IF;    
END;
-- A

-- 아래 예제처럼 THEN 절에 다수의 구문을 기술할 수도 있다.

VAR b1 NUMBER = 1

BEGIN
    IF :b1 = 1 THEN
        DBMS_OUTPUT.PUT_LINE('A');
        DBMS_OUTPUT.PUT_LINE('V');
    END IF;
END;
/*
    A
    V
*/