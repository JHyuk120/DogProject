/**********************************/
/* Table Name: 추천 */
/**********************************/
CREATE TABLE RECOMMEND(
        RECOMMENDNO                           NUMBER(8)         NOT NULL         PRIMARY KEY,
        MEMBERNO                              NUMBER(10)         NULL ,
        recipeno                                NUMBER(10)         NULL ,
        seq                                   NUMBER(2)         DEFAULT 1         NOT NULL,
        RDATE                                 DATE         NOT NULL,
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO),
  FOREIGN KEY (recipeno) REFERENCES recipe (recipeno)
);

COMMENT ON TABLE RECOMMEND is '추천';
COMMENT ON COLUMN RECOMMEND.RECOMMENDNO is '추천번호';
COMMENT ON COLUMN RECOMMEND.MEMBERNO is '회원번호';
COMMENT ON COLUMN RECOMMEND.recipeno is '카테고리번호';
COMMENT ON COLUMN RECOMMEND.seq is '추천 우선순위';
COMMENT ON COLUMN RECOMMEND.RDATE is '추천 날짜';

DROP SEQUENCE RECOMMEND_SEQ;

CREATE SEQUENCE RECOMMEND_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 존재하는 memberno, cateno 등록
INSERT INTO recommend(recommendno, memberno, itemno, seq, rdate)
VALUES(RECOMMEND_SEQ.nextval, 1,1,1,sysdate);

-- 1번 회원은 9번 카테고리를 추천필요.
SELECT recommendno, memberno, itemno, seq, rdate FROM recommend ORDER BY recommendno ASC;

