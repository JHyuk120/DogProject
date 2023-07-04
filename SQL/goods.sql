DROP TABLE goods;
DROP TABLE goods CASCADE CONSTRAINTS;
CREATE TABLE goods (
        goodsno                      NUMBER(10)              NOT NULL         PRIMARY KEY,
        adminno                   NUMBER(10)              NOT NULL , -- FK
        itemno                        NUMBER(10)              NOT NULL , -- FK
        gname                       VARCHAR2(50)         NOT NULL,
        content                      CLOB                          NOT NULL,
        cnt                               NUMBER(7)               DEFAULT 0         NOT NULL,
        word                          VARCHAR2(100)         NULL ,
        rdate                          DATE                           NOT NULL,
        file1                            VARCHAR(100)          NULL,  -- 원본 파일명 image
        file1saved                 VARCHAR(100)          NULL,  -- 저장된 파일명, image
        thumb1                      VARCHAR(100)          NULL,   -- preview image
        size1                          NUMBER(10)            DEFAULT 0 NULL,  -- 파일 사이즈
        price                           NUMBER(10)            DEFAULT 0 NULL,  
        grams                       NUMBER(5)              NOT NULL,
        origin                          VARCHAR(30)            NOT NULL,
        exdate                         VARCHAR(16)            NOT NULL,
        storage                     VARCHAR(20)             NOT NULL,
        dc                                NUMBER(10)            DEFAULT 0 NULL,  
        saleprice                    NUMBER(10)           DEFAULT 0 NULL,  
        salecnt                       NUMBER(10)            DEFAULT 0 NULL,
        point                           NUMBER(10)            DEFAULT 0 NULL,  

  FOREIGN KEY (adminno) REFERENCES admin (adminno),
  FOREIGN KEY (itemno) REFERENCES item (itemno)
);

COMMENT ON TABLE goods is '컨텐츠 - 상품';
COMMENT ON COLUMN goods.goodsno is '상품 번호';
COMMENT ON COLUMN goods.adminno is '관리자 번호';
COMMENT ON COLUMN goods.itemno is ' 품목 번호';
COMMENT ON COLUMN goods.gname is '상품명';
COMMENT ON COLUMN goods.content is '내용';
COMMENT ON COLUMN goods.word is '검색어';
COMMENT ON COLUMN goods.rdate is '등록일';
COMMENT ON COLUMN goods.file1 is '메인 이미지';
COMMENT ON COLUMN goods.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN goods.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN goods.size1 is '메인 이미지 크기';
COMMENT ON COLUMN goods.price is '정가';
COMMENT ON COLUMN goods.dc is '할인률';
COMMENT ON COLUMN goods.saleprice is '판매가';
COMMENT ON COLUMN goods.salecnt is '판매 수';
COMMENT ON COLUMN goods.point is '포인트';
COMMENT ON COLUMN goods.cnt is '품목 갯수';

DROP SEQUENCE goods_seq;

CREATE SEQUENCE goods_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;           
  
commit;

/** 등록 */
INSERT INTO goods (goodsno, adminno, itemno, seqno, gname, content, rdate, price, dc, saleprice, salecnt, point)
VALUES(goods_seq.nextval, 1, 1, 1, '치킨', '내용', sysdate, 10000, 10, 9000, 1, 10);

/** 전체 재료 목록 */
SELECT goodsno, adminno, itemno, gname, content, word, rdate, file1, file1saved, thumb1, size1, price, dc, saleprice, salecnt, point
FROM goods
ORDER BY goodsno ASC;

/** 특정 카테고리 글목록 */
SELECT goodsno, adminno, itemno, gname, content, word, rdate, file1, file1saved, thumb1, size1, price, dc, saleprice, salecnt, point
FROM goods 
WHERE itemno = 2
ORDER BY goodsno DESC;

/** 재료 조회 */
SELECT goodsno, adminno, itemno, gname, content, word, rdate, file1, file1saved, thumb1, size1, price, dc, saleprice, salecnt, point
FROM goods
WHERE goodsno = 7;

/** 카테고리별 검색 목록 */
SELECT goodsno, adminno, itemno, gname, content, word, rdate, file1, file1saved, thumb1, size1, price, dc, saleprice, salecnt, point
FROM goods
WHERE itemno=2 AND (UPPER(gname) LIKE '%' || UPPER('서울') || '%' 
                                                  OR UPPER(content) LIKE '%' || UPPER('서울') || '%' 
                                                  OR UPPER(word) LIKE '%' || UPPER('서울') || '%')

 ORDER BY goodsno DESC;   

/** 카테고리별 검색 목록 레코드 갯수 */
SELECT COUNT(*) as cnt
FROM goods
WHERE itemno=2 AND (UPPER(gname) LIKE '%' || UPPER('서울') || '%' 
                                                  OR UPPER(content) LIKE '%' || UPPER('서울') || '%' 
                                                  OR UPPER(word) LIKE '%' || UPPER('서울') || '%');
                                                  
/** 카테고리별 검색 목록 + 페이징 + 메인 이미지 */
SELECT goodsno, adminno, itemno, gname, content, word, rdate, 
                                            file1, file1saved, thumb1, size1, price, dc, saleprice, salecnt, point, r
FROM (
              SELECT goodsno, adminno, itemno, gname, content, word, rdate, 
                                            file1, file1saved, thumb1, size1, price, dc, saleprice, salecnt, point, rownum as r
              FROM (
                            SELECT goodsno, adminno, itemno, gname, content, word, rdate, 
                                            file1, file1saved, thumb1, size1, price, dc, saleprice, salecnt, point
                            FROM goods
                            WHERE itemno=2 AND (UPPER(gname) LIKE '%' || UPPER('서울') || '%' 
                                                                OR UPPER(content) LIKE '%' || UPPER('서울') || '%' 
                                                                OR UPPER(word) LIKE '%' || UPPER('서울') || '%')

                        ORDER BY goodsno DESC
               )
    )
WHERE r >= 1 AND r <= 3;

/** 글 수정 */
UPDATE goods
SET gname=저녁, content=밥, cnt=100,  word='00', price=3333, dc=12
WHERE goodsno = 88;

/** 글 삭제 */
DELETE FROM goods
WHERE goodsno=6;

/** 특정 카테고리에 속한 레코드 갯수를 리턴 */
SELECT COUNT(*) as cnt 
FROM goods 
WHERE itemno=2;

/** 특정 카테고리에 속한 모든 레코드 삭제 */
  DELETE FROM goods
  WHERE itemno=2;
  

SELECT * FROM goods;