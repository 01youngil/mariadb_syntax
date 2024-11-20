-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환, on 조건을 통해 교집합찾기
select * from author inner join post on author.id = post.author_id;
select * from author as a inner join post as p on a.id = p.author_id;
select * from author a inner join post p on a.id = p.author_id;
-- 출력 순서만 달라질뿐 조회결과는 동일.
select * from post inner join author on author.id = post.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
-- post의 글쓴이가 없는 데이터는 포함x, 글쓴이 중에 글을 한번도 안쓴사람 포함x
select p.*, a.email from post p inner join author a on a.id = p.author_id;
-- 글쓴이가 있는 글의 제목, 내용, 그리고 글쓴이의 이메일만 출력하시오.
select p.title, p.contents, a.email from post p inner join author a on a.id = p.author_id;

-- 모든 글 목록을 출력하고, 만약 글쓴이가 있다면 이메일 정보를 출력.
-- left outer join -> left join 으로 생략가능
-- 글을 한번도 안 쓴 글쓴이 정보는 포함x
select p.*, a.email from post p left join author a on a.id=p.author_id;

-- 글쓴이를 기준으로 left join 할 경우, 글쓴이가 n개의 글을 쓸 수 있으므로 같은 글쓴이가 여러번 출력될 수 있음
-- author와 post가 1:n관계이므로.
-- 글쓴이가 없는 글은 포함x
select * from author a left join post p on a.id=p.author_id;

-- 실습) 글쓴이가 있는 글 중에서 글의 title과 저자의 email만을 출력하되,
-- 저자의 나이가 30세 이상인 글만 출력.
select p.title, a.email from post p left join author a on a.id = p.author_id where a.age >= 30;

-- 실습)글의 내용과 글의 저자의 이름이 있는, 글 목록을 출력하되 2024-06 이후에 만들어진 글만 출력.
select p.* from post p left join author a on a.id = p.author_id
where a.name is not null and p.contents is not null and date_format(p.created_time, '%Y-%m-%d')>='2024-06-01';

-- 실습) 조건에 맞는 도서와 저자 리스트 출력
SELECT b.book_id, a.author_name, date_format(b.published_date, '%Y-%m-%d')
from book b left join author a on b.author_id = a.author_id
where b.category = '경제' order by b.published_date;


-- union : 두 테이블의 select 결과를 횡으로 결합(기본적으로 distinct 적용)
-- 컬럼의 개수와 컬럼의 타입이 같아야함에 유의
-- union all : 중복까지 모두 포함
select name, email from author union select title, contents from post;


-- 서브쿼리 : select문 안에 또 다른 select문을 서브쿼리라 한다.
-- where절 안에 서브쿼리
-- 한번이라도 글을 쓴 author 목록 조회
select distinct a.* from author a inner join post p on a.id = p.author_id;
select * from author where id in (select author_id from post);

-- select절 안에 서브쿼리
-- author의 email과 author별로 본인이 쓴 글의 개수를 출력
select a.email, (select count(*) from post where author_id=a.id) as count from author a; 
-- from절 안에 서브쿼리
select a.name from (select * from author) as a;