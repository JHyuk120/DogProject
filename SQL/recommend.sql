/**********************************/
/* Table Name: 추천 */
/**********************************/
DROP table RECOMMEND; 
CREATE TABLE RECOMMEND(
        RECOMMENDNO                           NUMBER(8)         NOT NULL         PRIMARY KEY,
        MEMBERNO                              NUMBER(10)         NULL ,
        itemno                                NUMBER(10)         NULL ,
        seq                                   NUMBER(2)         DEFAULT 1         NOT NULL,
        RDATE                                 DATE         NOT NULL,
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO) ON DELETE CASCADE,
  FOREIGN KEY (itemno) REFERENCES item (itemno)
);

COMMENT ON TABLE RECOMMEND is '추천';
COMMENT ON COLUMN RECOMMEND.RECOMMENDNO is '추천번호';
COMMENT ON COLUMN RECOMMEND.MEMBERNO is '회원번호';
COMMENT ON COLUMN RECOMMEND.itemno is '카테고리번호';
COMMENT ON COLUMN RECOMMEND.seq is '추천 우선순위';
COMMENT ON COLUMN RECOMMEND.RDATE is '추천 날짜';

DROP SEQUENCE recoomend_seq;

CREATE SEQUENCE recommend_seq
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지

commit;
-- 존재하는 memberno, recipeno 등록
INSERT INTO recommend(recommendno, memberno, itemno, seq, rdate)
VALUES(RECOMMEND_SEQ.nextval, 1,1,1,sysdate);

INSERT INTO recommend(recommendno, memberno, itemno, seq, rdate)
VALUES(RECOMMEND_SEQ.nextval, 2,2,1,sysdate);

INSERT INTO recommend(recommendno, memberno, itemno, seq, rdate)
VALUES(RECOMMEND_SEQ.nextval, 3,3,1,sysdate);
INSERT INTO recommend(recommendno, memberno, itemno, seq, rdate)
VALUES(RECOMMEND_SEQ.nextval, 4,4,1,sysdate);
INSERT INTO recommend(recommendno, memberno, itemno, seq, rdate)
VALUES(RECOMMEND_SEQ.nextval, 5,5,1,sysdate);

------------------------------------
-- 추천 눌렀는지 확인
SELECT  COUNT(*) as cnt
FROM recommend
WHERE memberno = 26;


SELECT *FROM item;
SELECT *FROM member;
SELECT *FROM recommend;
SELECT memberno FROM member WHERE id='user3';

-----추천 시스템 출력

  SELECT recipeno, memberno, itemno, title, article, recom, cnt, replycnt, rdate,
             file1, file1saved, thumb1, size1, r
  FROM (
             SELECT recipeno, memberno, itemno, title, article, recom, cnt, replycnt, rdate,
                        file1, file1saved, thumb1, size1, rownum as r
             FROM (
                       SELECT recipeno, memberno, itemno, title, article, recom, cnt, replycnt, rdate,
                                  file1, file1saved, thumb1, size1
                       FROM recipe
                       WHERE itemno=1
                       ORDER BY recom ASC
             )          
  )
  WHERE r >= 1 AND 10 >= r;
  
-------------------------------
    SELECT recipeno, memberno, itemno, title, article, recom, cnt, replycnt,
                      passwd, word, rdate, file1,file1saved,
                      thumb1, size1, youtube, ingredient, review, star, mname, r
    FROM ( SELECT recipeno, memberno, itemno, title, article, recom, cnt, replycnt,
                      passwd, word, rdate, file1,file1saved,
                      thumb1, size1, youtube, ingredient, review, star, mname,
                      ROW_NUMBER() OVER (ORDER BY recom DESC) AS r
           FROM recipe
           ORDER BY rdate DESC
    
    )
    WHERE r <= 5;
--------------------------------------------------------------------------------
SELECT recipeno, memberno, itemno, title, article, recom, cnt, replycnt,
           passwd, word, rdate, file1, file1saved,
           thumb1, size1, youtube, ingredient, review, star, mname,r
FROM (
    SELECT recipeno, memberno, itemno, title, article, recom, cnt, replycnt,
           passwd, word, rdate, file1, file1saved,
           thumb1, size1, youtube, ingredient, review, star, mname,
           ROW_NUMBER() OVER (ORDER BY recom DESC) AS r
    FROM recipe
    ORDER BY recom DESC
)
WHERE r <= 5;

SELECT recom FROM recipe ORDER BY recom DESC;