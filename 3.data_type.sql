--  tinyint 는 -128~127 까지 표현 (1Byte 할당)
-- author 테이블에 age 컬럼 추가
alter table author add column age tinyint;

-- data insert 테스트 : 200살 insert
insert into author(id,age) values(6,200);
alter table author modify column age tinyint unsigned;
insert into author(id,age) values(6,200);

-- decimal실습
-- decimal(정수부 자릿수,소수부 자릿수)
alter table post add column price decimal(10, 3);

-- decimal 소수점 초과 후 값 짤림 현상
insert into post(id, title, price) values(2, 'java programing', 10.33412);

-- 문자열 실습
-- char() : 고정길이(0~255), 설정한 크기만큼 공간차지
-- varchar() : 가변길이(0~65535), 입력된 크기만큼 공간차지
-- text : 가변길이(0~65535), 최대크기 설정불가
alter table author add column self_introduction text;
insert into author(id,self_introduction) values(7,'안녕하세요');

-- blob(바이너리데이터) 타입 실습
alter table author add column profile_image longblob;
insert into author(id, profile_image) values(8, load_file('파일경로'));--안될경우 이미지파일을 c드라이브 밑에

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role컬럼 추가
alter table author add column role enum('user', 'admin') not null default 'user';
-- user값 세팅 후 insert
insert into author(id,role) values(10, 'user');
-- users값 세팅 후 insert
insert into author(id,role) values(11, 'users');
-- 아무것도 안넣고 insert(default 값)
insert into author(id,name,email) values(11, 'hong','hong12@naver.com');

-- date : 날짜, datetime : 날짜 및 시분초(microseconds)
-- datetime 은 입력,수정,조회시에 문자열 형식을 활용
alter table post add column created_time datetime default current_timestamp();
update post set created_time = '2024-11-18 00:00:05' where id = 3;

-- 조회시 비교연산자
select * from author where id >= 2 and id <=4;
select * from author where id between 2 and 4; --위와 같은 구문
select * from author where id not(id < 2 or id >4);
select * from author where id in(2,3,4);
-- select * from author where id in(select author_id from post); 로도 응용가능
select * from author where id not in(1,5); -- 1 <= id <=5 일때

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%h'; --h로 끝나는 title 검색
select * from post where title like 'h%'; --h로 시작하는
select * from post where title like '%h%'; --h가 들어가는

-- regexp : 정규표현식을 활용한 조회
select * from post where title regexp '[a-z]'; --하나라도 알파벳 소문자가 들어있으면
select * from post where title regexp '[가-힣]'; -하나라도 한글이 포함돼있으면

-- 날짜변환 cast, convert : 숫자 -> 날짜, 문자 -> 날짜
select cast(20241119 as date);
select cast('20241119' as date);
select convert(20241119, date);
select convert('20241119', date);
-- 문자 -> 숫자 변환
select cast('12' as unsigned);

-- 날짜조회 방법 ※※
-- like패턴, 부등호 활용, date_format
select * from post where created_time like '2024-11%' --문자열조회
select * from post where created_time >= '2024-01-01' and created_time < '2025-01-01';
-- date_format
select date_format(created_time, '%Y-%m-%d') from post;
select date_format(created_time, '%H:%i:%s') from post;
select * from post where date_format(created_time, '%Y')='2024';
select * from post where cast(date_format(created_time, '%Y')='2024'as unsigned) = 2024;

-- 현재날짜,시간
select now();