DROP table reply;

CREATE TABLE reply (
    replyno NUMBER(10) NOT NULL PRIMARY KEY,
    memberno NUMBER(10) NOT NULL,
    recipeno  NUMBER(10) NOT NULL,
    replycont  CLOB    NOT NULL,
    file1       VARCHAR(100),  -- 원본 파일명 image
    file1saved  VARCHAR(100),  -- 저장된 파일명, image
    thumb1      VARCHAR(100),   -- preview image
    size1       NUMBER(10) DEFAULT 0,  -- 파일 사이즈
    rdate       DATE,
    recom       NUMBER(7)    DEFAULT 0  NOT NULL,
    replycnt   NUMBER(7)    DEFAULT 0  NOT NULL,
    ratingValue NUMBER(7)    DEFAULT 5,
    ratingAvg   NUMBER(7,2)    DEFAULT 0,
    FOREIGN KEY (memberno) REFERENCES member (memberno),
    FOREIGN KEY (recipeno) REFERENCES recipe (recipeno)
);

COMMENT ON TABLE reply is '댓글,평점';
COMMENT ON COLUMN reply.replyno is '리뷰 번호';
COMMENT ON COLUMN reply.memberno is '회원 번호';
COMMENT ON COLUMN reply.recipeno is '컨텐츠(레시피) 번호';
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
  
-- 리뷰 작성 
INSERT INTO reply(replyno,memberno,recipeno,replycont,rdate,ratingValue) 
VALUES(reply_seq.nextval,1,17,'맛있어요^^',sysdate,5);
commit;

-- 리뷰 조회
SELECT replyno,memberno,recipeno,replycont,rdate,ratingValue,ratingAVG
FROM reply
WHERE recipeno = 17;

-- 리뷰 조회 페이징
SELECT replyno,memberno,mid,recipeno,replycont,rdate,ratingValue,ratingAVG, r
   FROM (
              SELECT replyno,memberno,mid,recipeno,replycont,rdate,ratingValue,ratingAVG, rownum as r
              FROM (
                         SELECT r.replyno, r.memberno, m.id AS mid, r.recipeno, r.replycont, r.rdate, r.ratingValue,r.ratingAVG
                        FROM reply r 
                        JOIN member m 
                        ON r.memberno = m.memberno
                        WHERE r.recipeno = 17
                        ORDER BY rdate DESC
               )
    );


-- 컨텐츠 평점
SELECT AVG(reply.ratingValue) 
FROM reply 
INNER JOIN member ON reply.memberno = member.memberno 
WHERE reply.recipeno = 3 
ORDER BY reply.rdate DESC;

-- 리뷰 수정
UPDATE reply
SET replycont = '우리 아이가 잘먹어요^^'
WHERE replyno =3;

-- 리뷰 갯수
SELECT COUNT(*) as cnt
FROM  reply
WHERE recipeno = 6;

-- 리뷰 삭제
DELETE FROM reply
WHERE replyno = 3;

-- 리뷰 읽어오기
SELECT replycont
FROM reply
WHERE replyno=9;

-- recipeno별 댓글 수 
SELECT COUNT(*) as cnt
FROM reply
WHERE recipeno=6;
