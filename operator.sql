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