DROP table review;

CREATE TABLE review (
    reviewno NUMBER(10) NOT NULL PRIMARY KEY,
    memberno NUMBER(10) NOT NULL,
    goodsno  NUMBER(10) NOT NULL,
    reviewcont  CLOB    NOT NULL,
    file2       VARCHAR(100),  -- 원본 파일명 image
    file2saved  VARCHAR(100),  -- 저장된 파일명, image
    thumb2      VARCHAR(100),   -- preview image
    size2       NUMBER(10) DEFAULT 0,  -- 파일 사이즈
    rdate       DATE,
    recom       NUMBER(7)    DEFAULT 0  NOT NULL,
    reviewcnt   NUMBER(7)    DEFAULT 0  NOT NULL,
    ratingValue NUMBER(7)    DEFAULT 5,
    ratingAvg   NUMBER(7,2)    DEFAULT 0,
    FOREIGN KEY (memberno) REFERENCES member (memberno),
    FOREIGN KEY (goodsno) REFERENCES goods (goodsno)
);

COMMENT ON TABLE review is '댓글,평점';
COMMENT ON COLUMN review.reviewno is '리뷰 번호';
COMMENT ON COLUMN review.memberno is '회원 번호';
COMMENT ON COLUMN review.goodsno is '컨텐츠(상품) 번호';
COMMENT ON COLUMN review.reviewcont is '리뷰 내용';
COMMENT ON COLUMN review.ratingValue is '댓글 평점';
COMMENT ON COLUMN review.ratingAvg is '게시물 평점';
COMMENT ON COLUMN review.file1 is '메인 이미지';
COMMENT ON COLUMN review.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN review.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN review.size1 is '메인 이미지 크기';
COMMENT ON COLUMN review.rdate is '작성일';
COMMENT ON COLUMN review.recom is '추천수';
COMMENT ON COLUMN review.reviewcnt is '리뷰수';
COMMENT ON COLUMN review.ratingValue is '댓글별 점수';
COMMENT ON COLUMN review.ratingAvg is '게시물점 평점';
DROP SEQUENCE review_seq;

CREATE SEQUENCE review_seq
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
  
-- 리뷰 작성 
INSERT INTO review(reviewno,memberno,goodsno,reviewcont,rdate,ratingValue) 
VALUES(review_seq.nextval,1,53,'좋아요^^',sysdate,5);
commit;

-- 리뷰 조회

SELECT r.reviewno,r.memberno,r.goodsno,m.id AS mid,r.reviewcont,r.rdate,r.ratingValue,r.ratingAVG,r.file2,r.file1saved,r.thumb2, r.size2
FROM review r JOIN member m on r.memberno = m.memberno
WHERE r. goodsno =21
ORDER BY rdate ASC;

-- 리뷰 조회 페이징
SELECT reviewno,memberno,mid,goodsno,reviewcont,rdate,ratingValue,ratingAVG, r
   FROM (
              SELECT reviewno,memberno,mid,goodsno,reviewcont,rdate,ratingValue,ratingAVG, rownum as r
              FROM (
                         SELECT r.reviewno, r.memberno, m.id AS mid, r.goodsno, r.reviewcont, r.rdate, r.ratingValue,r.ratingAVG
                        FROM review r 
                        JOIN member m 
                        ON r.memberno = m.memberno
                        WHERE r.goodsno = 21
                        ORDER BY rdate DESC
               )
    );
----------------------


-- 컨텐츠 평점
SELECT ROUND(AVG(ratingValue), 2) AS average_rating
FROM review 
WHERE goodsno = 86;

-- 리뷰 수정
UPDATE review
SET reviewcont = '우리 아이가 잘먹어요^^'
WHERE goodsno =3;

-- 리뷰 갯수
SELECT COUNT(*) as cnt
FROM  review
WHERE goodsno = 6;

-- 리뷰 삭제
DELETE FROM review
WHERE reivewno = 3;

-- 리뷰 읽어오기
SELECT replycont
FROM reply
WHERE replyno=9;

-- recipeno별 댓글 수 
SELECT COUNT(*) as cnt
FROM reply
WHERE recipeno=6;
--
SELECT *
FROM review;






