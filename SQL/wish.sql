DROP TABLE wish;

CREATE TABLE wish(
    wishno                         NUMBER(10)      NOT NULL    PRIMARY KEY,
    memberno                       NUMBER(10)    NOT NULL ,
    goodsno                          NUMBER(10)    NOT NULL ,
    rdate                              DATE     NOT NULL, 
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO) ON DELETE CASCADE,
  FOREIGN KEY (GOODSNO) REFERENCES GOODS (GOODSNO)
);

COMMENT ON TABLE wish is '찜하기';
COMMENT ON COLUMN wish.WISHNO is '찜하기 번호';
COMMENT ON COLUMN wish.MEMBERNO is '회원 번호';
COMMENT ON COLUMN wish.GOODSNO is '재료 번호';
COMMENT ON COLUMN wish.rdate is '찜하기 날짜';


DROP SEQUENCE wish_seq;
CREATE SEQUENCE wish_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;    
  
  commit;
  
  
INSERT INTO wish(wishno, memberno, goodsno, rdate)
VALUES (wish_seq.nextval, 116, 1, sysdate);


select * from wish;
select * from wish where memberno = 116;
select * from goods;
select * from member;

select count(haddu) from recom where haddu = 1 AND recipeno=18;

delete from recom;


select count(wishno) from wish where wishno = 1;

--check_cnt
select count(goodsno) from wish where goodsno = 1 AND memberno = 116;

-- delete
delete from wish where memberno = 5;


--adminList
select title, wish, rdate from goods order by wish desc;
select * from goods;

--memberList
select g.gname, g.content, g.goodsno,w.memberno,g.price,g.rdate,g.saleprice,g.dc,g.point
from goods g inner join wish w on g.goodsno = w.goodsno 
where w.memberno =5
order by w.rdate desc;


select * from wish;
select * from goods;
select * from member;

-- 내가 찜한 항목 수
select count(goodsno) as cnt
from wish
where memberno = 1;

-- 내가 저장한 레시피 항목 수
select count(recipeno) as cnt
from recom
where memberno = 1;


SELECT p.recipeno, p.memberno, p.itemno, p.title, p.article, p.recom, p.cnt, p.replycnt,
                      p.passwd, p.word, p.rdate, p.file1,p.file1saved,
                      p.thumb1, p.size1, p.youtube, p.ingredient, p.review, p.star, p.mname
    FROM recipe p inner join recom c on p.recipeno = c.recipeno
    WHERE c.memberno = 116
    ORDER BY c.rdate DESC;