--  author 테이블에 post_count컬럼 추가
alter table author add column post_count int default 0;

-- post에 글쓴후에, author테이블에 post_count값에 +1을 시키는 트랜잭션 테스트
start transaction;
update author set post_count = post_count + 1 where id = 4;
insert into post(title, contents, author_id) values('hello java', 'hello java is ...', 100);
commit;--또는 rollback;

-- 위 transaction은 실패시 자동으로 rollback 어려움
-- stored 프로시저를 활용하여 자동화된 rollback 프로그래밍
DELIMITER //
CREATE PROCEDURE 트랜잭션테스트()
BEGIN
    DECLARE exit handler for SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    start transaction;
    update author set post_count = post_count + 1 where id = 4;
    insert into post(title, contents, author_id) values('hello java', 'hello java is ...', 4);
    commit;--또는 rollback;

END //
DELIMITER ;

-- 프로시저 호출
CALL 트랜잭션테스트();


-- 사용자에게 입력받을 수 있는 프로시저 생성
DELIMITER //
CREATE PROCEDURE 트랜잭션테스트2(in titleinput varchar(255), in contentsinput varchar(255),in idinput bigint)
BEGIN
    DECLARE exit handler for SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    start transaction;
    update author set post_count = post_count + 1 where id = 4;
    insert into post(title, contents, author_id) values(titleinput, contentsinput, idinput);
    commit;--또는 rollback;

END //
DELIMITER ;