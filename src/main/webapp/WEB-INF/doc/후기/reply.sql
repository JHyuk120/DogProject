DROP table reply;
SELECT *
FROM recipe;

CREATE TABLE reply (
    replyno NUMBER(10) NOT NULL PRIMARY KEY,
    memberno NUMBER(10) NOT NULL,
    id       VARCHAR(30)   NOT NULL ,
    recipeno  NUMBER(10) NOT NULL,
    replycont  CLOB    NOT NULL,
    file1       VARCHAR(100),  -- 원본 파일명 image
    file1saved  VARCHAR(100),  -- 저장된 파일명, image
    thumb1      VARCHAR(100),   -- preview image
    size1       NUMBER(10) DEFAULT 0,  -- 파일 사이즈
    rdate       DATE,
    recom       NUMBER(7)    DEFAULT 0  NOT NULL,
    replycnt   NUMBER(7)    DEFAULT 0  NOT NULL,
    ratingValue FLOAT(7)    DEFAULT 0,
    ratingAvg   FLOAT(7)    DEFAULT 0,
    FOREIGN KEY (memberno) REFERENCES member (memberno),
    FOREIGN KEY (id) REFERENCES member (id),
    FOREIGN KEY (recipeno) REFERENCES recipe (recipeno)
);


COMMENT ON TABLE reply is '댓글,평점';
COMMENT ON COLUMN reply.replyno is '리뷰 번호';
COMMENT ON COLUMN reply.memberno is '회원 번호';
COMMENT ON COLUMN reply.recipeno is '컨텐츠(레시피) 번호';
COMMENT ON COLUMN reply.id is '회원id';
COMMENT ON COLUMN reply.replycont is '리뷰 내용';
COMMENT ON COLUMN reply.ratingValue is '댓글 평점';
COMMENT ON COLUMN reply.ratingAvg is '게시물 평점';
COMMENT ON COLUMN reply.file1 is '메인 이미지';
COMMENT ON COLUMN reply.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN reply.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN reply.size1 is '메인 이미지 크기';
COMMENT ON COLUMN reply.rdate is '작성일';
COMMENT ON COLUMN reply.recom is '추천수';
COMMENT ON COLUMN reply.replycnt is '리뷰수';
COMMENT ON COLUMN reply.ratingValue is '댓글별 점수';
COMMENT ON COLUMN reply.ratingAvg is '게시물점 평점';
DROP SEQUENCE reply_seq;

 

CREATE SEQUENCE reply_seq
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
  
SELECT * FROM recipe;
-- 리뷰 작성 
INSERT INTO reply(replyno,memberno,id,recipeno,replycont,rdate,ratingValue) 
VALUES(reply_seq.nextval,1, (SELECT id FROM member WHERE memberno = 1),6,'맛있어요^^',sysdate,5);
commit;

-- 리뷰 조회
SELECT replyno,memberno,(SELECT id FROM member WHERE memberno = 1)as id,recipeno,replycont,rdate,ratingValue,ratingAVG
FROM reply
WHERE recipeno = 6
ORDER BY rdate ASC;
-- 리뷰 조회 페이징
   SELECT replyno,memberno,(SELECT id FROM member WHERE memberno = #{memberno})as id,recipeno,replycont,rdate,ratingValue,ratingAVG, r
   FROM (
              SELECT replyno,memberno,(SELECT id FROM member WHERE memberno = #{memberno})as id,recipeno,replycont,rdate,ratingValue,ratingAVG, rownum as r
              FROM (
                        SELECT replyno,memberno,(SELECT id FROM member WHERE memberno = #{memberno})as id,recipeno,replycont,rdate,ratingValue,ratingAVG
                        FROM reply
                        ORDER BY rdate DESC
               )
    )
    WHERE <![CDATA[ r >= #{start_num} AND r <= #{end_num} ]]>
     
    <!--  1 page: WHERE r >= 1 AND r <= 10; 
            2 page: WHERE r >= 11 AND r <= 20;
            3 page: WHERE r >= 21 AND r <= 30; -->


-- 평점조회
SELECT reply.ratingValue 
FROM reply 
INNER JOIN member ON reply.memberno = member.memberno 
WHERE replyno = 1
ORDER BY reply.rdate DESC;
-- 전체 평점 조회


SELECT AVG(ratingValue)
FROM reply 
WHERE recipeno = 6;
commit;

UPDATE reply
SET ratingAvg = (
    SELECT ROUND(AVG(ratingValue), 2)
    FROM reply
    WHERE recipeno = 6
)
WHERE recipeno = 6;





SELECT ratingAvg
FROM reply
WHERE recipeno =6;


-- 컨텐츠 평점
SELECT AVG(reply.ratingValue) 
FROM reply 
INNER JOIN member ON reply.memberno = member.memberno 
WHERE reply.recipeno = 3 
ORDER BY reply.rdate DESC;

-- 리뷰 수정
UPDATE reply
SET replycont = '우리 아이가 잘먹어요^^'
WHERE recipeno =3;
-- 리뷰 갯수
SELECT COUNT(*) as cnt
FROM  reply
WHERE recipeno = 6;
-- 리뷰 사진 수정
-- 리뷰 사진 삭제
-- 리뷰 삭제
DELETE FROM reply
WHERE recipeno = 3;
rollback;
commit;

--count


