-- mariadb 서버에 접속
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases;

-- 스미카(database) 생성 : 중요
CREATE DATABASE board;

-- 스키마 삭제
drop database board;

-- 데이터베이스 선택 : 중요
use board;

-- 테이블목록조회 : 중요
show tables;

-- 문자 인코딩(체계) 조회
show variables like 'character_set_server';

-- 문자 인코딩 변경
alter database board default character set = utf8mb4;

-- 테이블 생성
create table author(id int primary key, name varchar(255), email varchar(255), password varchar(255));

-- 테이블 컬럼조회 : 중요
describe author;

-- 데이터 컬럼 상세조회
show full columns from author;

-- 테이블 생성명령문 조회
show create table author;

-- post테이블 신규 생성(id, title, content, author_id) : 중요
create table post(id int primary key, title varchar(255), content varchar(255), author_id int, foreign key(author_id) references author(id));

-- 테이블 index(성능향상옵션)조회//pk(primary key), fk(foreign key)에는 index 자동생성
show index from author;


-- alter문 : 테이블의 구조를 변경
-- 테이블의 이름 변경
alter table post rename posts;

-- 테이블 컬럼 추가 (타입 필요 o) : 중요
alter table author add column age int;

-- 테이블 컬럼 삭제 (타입 필요x)
alter table author drop column age;

-- 테이블 컬럼명 변경(타입 필요 o)
alter table post change column content contents varchar(255);

-- 테이블 컬럼 타입과 제약조건 변경 -> 덮어쓰기 됨에 유의: 중요
alter table author modify column email varchar(100) not null;

-- 실습 : author테이블에 address 컬럼추가, varchr255
alter table author add column address varchar(255);

-- 실습 : post테이블에 title은 not null로 변경, contents 3000자로  변경
alter table post modify column title varchar(255) not null;
alter table post modify column contents varchar(3000);

-- 테이블 삭제
show create table post;
drop table post;