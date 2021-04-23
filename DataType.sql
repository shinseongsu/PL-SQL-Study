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


