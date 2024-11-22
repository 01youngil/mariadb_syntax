-- 여러 사용자가 1개의 글을 수정할 수 있다 가정 후 DB 리뉴얼
-- author와 post가 n : m 관계가되어 관계테이블을 별도로 생성

drop database board; -- 기존 보드 삭제
create database board; -- 새 보드 생성
use board;

-- 테이블생성
create table author(id bigint primary key not null auto_increment,
email varchar(255) not null unique, password varchar(255), name varchar(255),
created_time datetime default current_timestamp());

create table post (id bigint primary key not null auto_increment,
title varchar(255) not null, contents varchar(255),
created_time datetime default current_timestamp());

-- 1:1 관계인 author_address
-- 1:1 관계의 보장은 author_id unique 설정

create table author_address(id bigint primary key not null auto_increment,
author_id bigint not null unique, city varchar(255), village varchar(255),
street varchar(255), created_time datetime default current_timestamp(),
foreign key(author_id) references author(id));

-- author_post는 연결테이블로 생성

create table author_post(id bigint primary key not null auto_increment,
author_id bigint not null, post_id bigint not null,
created_time datetime default current_timestamp(),
foreign key(author_id) references author(id),
foreign key(post_id) references post(id));

-- 복합키로 author_post생성
create table author_post2(
author_id bigint not null,
post_id bigint not null,
primary key(author_id, post_id),
foreign key(author_id) references author(id),
foreign key(post_id) references post(id));

-- insert

insert into author(email, password, name)
values ('park@naver.com',1234,'park');

insert into author_address(author_id,city,village,street)
values (4,'busan','cccc','ccc');

insert into post(title,contents)
values ('p','pppp');

insert into author_post(author_id,post_id)
values (4,6);


-- 내 id로 내가 쓴 글 조회
select p.* from post p inner join author_post ap on p.id=ap.post_id
where ap.author_id = 1;

-- 글을 2번 이상 쓴 사람에 대한 정보 조회
select a.* from author a inner join author_post ap on a.id = ap.author_id
group by a.id having count(a.id)>=2 order by author_id;





-----------------
create database order_system;
use order_system;

create table seller (id bigint primary key not null auto_increment,
name varchar(255) not null, email varchar(255) unique, phonenumber varchar(255) unique,
created_time datetime default current_timestamp());

create table buyer (id bigint primary key not null auto_increment,
name varchar(255) not null, email varchar(255) unique, phonenumber varchar(255) unique,
address varchar(255), created_time datetime default current_timestamp());

create table product (product_id bigint primary key not null auto_increment,
seller_id bigint not null, product_name varchar(255) not null,
remaining bigint not null, foreign key(seller_id) references seller(id));

create table order_number (order_id bigint primary key not null auto_increment,
buyer_id bigint not null, foreign key(buyer_id) references buyer(id));

create table order_detail (order_detail_number bigint primary key not null auto_increment,
order_id bigint not null, buyer_id bigint not null, product_id bigint not null,
count bigint not null, order_time datetime default current_timestamp(),
foreign key(order_id) references order_number(order_id),
foreign key(buyer_id) references buyer(id),
foreign key(product_id) references product(product_id));


-- seller insert
insert into seller(name, email, phonenumber)
values ('kim','kim@naver.com','01011111111');
insert into seller(name, email, phonenumber)
values ('lee','lee@naver.com','01022222222');
insert into seller(name, email, phonenumber)
values ('park','park@naver.com','01033333333');
insert into seller(name, email, phonenumber)
values ('choi','choi@naver.com','01044444444');
insert into seller(name, email, phonenumber)
values ('jang','jang@naver.com','01055555555');

-- buyer insert
insert into buyer(name, email, phonenumber, address)
values ('shin','shin@naver.com','01012121212', 'seoul');
insert into buyer(name, email, phonenumber, address)
values ('hwang','hwang@naver.com','01023232323', 'seoul');
insert into buyer(name, email, phonenumber, address)
values ('son','son@naver.com','01078787878', 'busan');
insert into buyer(name, email, phonenumber, address)
values ('hong','hong@naver.com','01059595959', 'ulsan');

-- product insert
insert into product(seller_id, product_name, remaining)
values (1, 'apple', 71);
insert into product(seller_id, product_name, remaining)
values (1, 'pear', 59);
insert into product(seller_id, product_name, remaining)
values (1, 'melon', 12);
insert into product(seller_id, product_name, remaining)
values (3, 'apple', 14);
insert into product(seller_id, product_name, remaining)
values (3, 'pineapple', 5);
insert into product(seller_id, product_name, remaining)
values (4,'orange', 63);
insert into product(seller_id, product_name, remaining)
values (5, 'grape', 42);
insert into product(seller_id, product_name, remaining)
values (5, 'watermelon', 10);

-- order_number insert
insert into order_number(order_id, buyer_id)
values (1,2);
insert into order_number(order_id, buyer_id)
values (2,4);
insert into order_number(order_id, buyer_id)
values (3,1);
insert into order_number(order_id, buyer_id)
values (4,2);
insert into order_number(order_id, buyer_id)
values (5,3);
insert into order_number(order_id, buyer_id)
values (6,1);

-- order_detail insert
insert into order_detail(order_id, buyer_id, product_id, count)
values (1,2,5,3);
insert into order_detail(order_id, buyer_id, product_id, count)
values (1,2,4,10);
insert into order_detail(order_id, buyer_id, product_id, count)
values (2,4,1,70);
insert into order_detail(order_id, buyer_id, product_id, count)
values (3,1,2,55);
insert into order_detail(order_id, buyer_id, product_id, count)
values (3,1,3,2);
insert into order_detail(order_id, buyer_id, product_id, count)
values (4,2,4,4);
insert into order_detail(order_id, buyer_id, product_id, count)
values (5,3,8,2);
insert into order_detail(order_id, buyer_id, product_id, count)
values (6,1,7,21);


----test

-- 등록된 판매자 중 판매중인 상품이 없는 판매자번호와 이름
select s.id, s.name from seller s
where s.id not in (select p.seller_id from product p);

-- 2번 구매자의 주문내역
select buyer_id, product_id, count
from order_detail where buyer_id = 2;

-- 5번 또는 7번 물품을 구매한 구매자번호, 상품번호, 구매한 수량
select buyer_id, product_id, count
from order_detail where product_id = 5 || product_id = 7;