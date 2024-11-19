-- case문
select 컬럼1, 컬럼2, 컬럼3,
-- if(컬럼4==비교값1){결과값1출력}else if(컬럼4==비교값2){결과값2출력}else{결과값3출력}
case 컬럼4
 when 비교값1 then 결과값1
 when 비교값2 then 결과값2
 else 결과값3
end
from 테이블명;
-----
select id, name, email,
case
    when name is null then '익명사용자'
    else name
end as '사용자명'
from author;

-- ifnull(a,b) : a가 null이면 b를 출력, null이 아니면 a출력
select id, email, ifnull(name, '익명사용자') as '사용자명' from author;

-- 문제풀이 경기도에 위치한 식품창고 목록 출력하기
SELECT WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS,
ifnull(freezer_yn,'N') as FREEZER_YN from food_warehouse where warehouse_name like '%경기%' order by warehouse_id asc;

-- if(a,b,c) :  a조건이 참이면 b반환, a조건이 거짓이면 c반환
select id, email, if(name is null, '익명사용자', name) as '사용자명' from author;

-- 조건에 부합하는 중고거래 상태 조회하기
SELECT board_id, writer_id, title, price,
case status
    when 'sale' then '판매중'
    when 'reserved' then '예약중'
    else '거래완료'
end as status
from used_goods_board
where created_date like '2022-10-05'
order by board_id desc;

-- 12세 이하인 여자 환자 목록출력하기
SELECT pt_name, pt_no, gend_cd, age,
ifnull(tlno,'NONE') as tlno
from patient where age <= 12 and gend_cd = 'W'
order by age desc, pt_name;