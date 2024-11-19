-- DML(Data Manipulation Language)
-- DCL(Data Control Language)


-- insert into : 테이블에 데이터 삽입
insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values(데이터1, 데이터2, 데이터3);
-- 문자열은 일반적으로 ''사용
insert into author(id, name, email) values(3, 'kim', 'kim@naver.com');

-- select : 데이터 조회, * : 모든컬럼을 의미
select * from author;
select name, email from author;

-- post 테이블 1줄 추가
insert into post(id,title,contents) values(3,'aaa','bbb');

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'posts';

-- insert문을 통해 author데이터 2개정도 추가, post 데이터 2개정도 추가(1개는 익명)


-- update : 데이터 수정
-- where 문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의
update 테이블명 컬럼명 where id=1;
update author set name='홍길동' where id=1; 
update author set name='홍길동2', email='honggildong@naver.com' where id=2;

-- delete : 데이터 삭제
-- where문을 생략할 경우 모든 데이터가 삭제됨에 유의
delete from author where id = 5;

-- select : 조회
select * from author; -- 어떠한 조건없이 모든 컬럼 조회
select * from author where id=1; -- where 뒤에 조회조건을 통해 조회
select * from author where name='honggildong';
select * from author where id>3;
select * from author where id>2 and name = 'kim'; -- 또는일 경우 or

--  중복제거 조회 : distinct
select distinct name from author;

-- 정렬 : order by + 컬럼명
-- 아무런 정렬조건없이 조회할 경우에는 pk기준으로 오름차순 정렬
-- asc : 오름차순, desc : 내림차순
select * from author order by name desc;

--  멀티컬럼 order by : 여러컬럼으로 정령, 먼저 쓴 컬럼 우선정렬. 중복시, 그 다음 정렬옵션 적용
select * from author order by name desc, email asc;

-- 결과값 개수 제한
select * from author order by id desc limit 2;

-- 별칭을(ellas) 이용한 select
select name as '이름', email as '이메일' from author;
select name, email from author;
select a.name, a.email from author as a;
select a.name, a.email from author a;

-- null을 조회조건으로 활용
select * from author where password is null;
select * from author where password is not null;

-- 프로그래머스 sql 문제풀이
-- 여러 기준으로 정렬하기
-- 상위 n개 레코드