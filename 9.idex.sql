-- index조회
show index from author;

-- 조회시 index를 통해 조회하려면 반드시 where조건에 해당 칼럼이 있어야함
select * from author where email = 'honggildong@naver.com';

-- id에 index가 걸려있으므로, id의 index를 통해 조회 후 name full scan
select * from author where id=1 and name = 'honggilodng';

-- 만약에 두 컬럼에 동시에 index가 걸려있다면 해당 index활용
-- 만약에 두 컬럼 각각 index가 설정돼 있다면 mariadb엔진에서 최적의 알고리즘 실행
select * from author where name = 'honggildong' and address = '사용자';

-- index제거
alter table author drop index 인덱스명;

-- 데이터 대량생성 후 조회(100만개)
--  대량 데이터 생성 프로시저 생성
DELIMITER //
CREATE PROCEDURE insert_authors()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE email VARCHAR(100);
    DECLARE batch_size INT DEFAULT 10000; -- 한 번에 삽입할 행 수
    DECLARE max_iterations INT DEFAULT 100; -- 총 반복 횟수 (100000000 / batch_size)
    DECLARE iteration INT DEFAULT 1;
    WHILE iteration <= max_iterations DO
        START TRANSACTION;
        WHILE i <= iteration * batch_size DO
            SET email = CONCAT('seonguk', i, '@naver.com');
            INSERT INTO author (email) VALUES (email);
            SET i = i + 1;
        END WHILE;
        COMMIT;
        SET iteration = iteration + 1;
        DO SLEEP(0.1); -- 각 트랜잭션 후 0.1초 지연
    END WHILE;
END //
DELIMITER ;

-- 프로시저 호출
call insert_authors();

-- index생성
create index email_index on author(email);

-- 조회성능 재확인

-- 확인 후 데이터 삭제후 재생성
show create table author;
show create table post;

drop database board;
create database board;
use board;
