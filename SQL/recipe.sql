DROP TABLE recipe CASCADE CONSTRAINTS;
DROP TABLE recipe;
drop table reply;

CREATE TABLE recipe(
        recipeno            NUMBER(10)      NOT NULL         PRIMARY KEY,
        itemno              NUMBER(10)      NOT NULL , -- FK
        memberno        NUMBER(10)     NOT NULL, -- FK
        title               VARCHAR2(50)    NOT NULL,
        article             CLOB            NOT NULL,
        recom               NUMBER(7)       DEFAULT 0        NOT NULL,
        cnt                 NUMBER(7)       DEFAULT 0         NOT NULL,
        replycnt            NUMBER(7)       DEFAULT 0         NOT NULL,
        passwd              VARCHAR2(15)    NOT NULL,
        word                VARCHAR2(100)   NULL ,
        rdate               DATE            NOT NULL,
        file1         VARCHAR(100)    NULL,  -- 원본 파일명 image
        file1saved    VARCHAR(100)    NULL,  -- 저장된 파일명, image
        thumb1              VARCHAR(100)    NULL,   -- preview image
        size1               NUMBER(10)      DEFAULT 0 NULL,  -- 파일 사이즈
        youtube             VARCHAR2(1000)            NULL,
        ingredient         CLOB            NOT NULL,
        review              CLOB            NULL,
        star                NUMBER(10)       DEFAULT 0         NOT NULL,
        mname           VARCHAR(30)   NOT NULL,
        difficulty          VARCHAR2(20)    NOT NULL,
        time                VARCHAR2(50)    NOT NULL,
        gname               CLOB            NOT NULL,
    FOREIGN KEY (memberno) REFERENCES member (memberno) ON DELETE CASCADE,
    FOREIGN KEY (itemno) REFERENCES item (itemno)
);

COMMENT ON TABLE recipe is '레시피';
COMMENT ON COLUMN recipe.recipeno is '레시피 번호';
COMMENT ON COLUMN recipe.itemno is '품목 번호';
COMMENT ON COLUMN recipe.memberno is '회원 번호';
COMMENT ON COLUMN recipe.title is '제목';
COMMENT ON COLUMN recipe.article is '레시피 설명';
COMMENT ON COLUMN recipe.recom is '추천수';
COMMENT ON COLUMN recipe.cnt is '조회수';
COMMENT ON COLUMN recipe.replycnt is '댓글수';
COMMENT ON COLUMN recipe.passwd is '패스워드';
COMMENT ON COLUMN recipe.word is '검색어';
COMMENT ON COLUMN recipe.rdate is '등록일';
COMMENT ON COLUMN recipe.file1 is '레시피 이미지';
COMMENT ON COLUMN recipe.file1saved is '실제 저장된 레시피 이미지';
COMMENT ON COLUMN recipe.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN recipe.size1 is '메인 이미지 크기';
COMMENT ON COLUMN recipe.youtube is '유튜브';
COMMENT ON COLUMN recipe.ingredient is '재료';
COMMENT ON COLUMN recipe.review is '리뷰';
COMMENT ON COLUMN recipe.star is '별점';
COMMENT ON COLUMN recipe.mname is '작성자이름';
COMMENT ON COLUMN recipe.star is '별점';
COMMENT ON COLUMN recipe.difficulty is '난이도';
COMMENT ON COLUMN recipe.time is '소요시간';
COMMENT ON COLUMN recipe.gname is '재료 이름';


COMMIT;

DROP SEQUENCE recipe_seq;

CREATE SEQUENCE recipe_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                    -- 다시 1부터 생성되는 것을 방지


/** 레시피 등록 */
INSERT INTO recipe(recipeno, itemno, title, article, passwd, word,ingredient, rdate)
VALUES(recipe_seq.nextval, 1, '레시피test', 'content', '1234', 'word', '재료', sysdate);

/** 레시피에 등록된 글목록 */
SELECT recipeno, adminno, itemno, title, article, recom, cnt, replycnt, passwd, word, rdate, file1,file1saved, thumb1, size1, youtube, ingredient, review, star
FROM recipe 
ORDER BY recipeno DESC;

/** 특정 카테고리에 등록된 글목록 */
SELECT recipeno, itemno, title, article, recom, cnt, replycnt, passwd, word, rdate, file1,file1saved, thumb1, size1, youtube, ingredient, review, star
FROM recipe
WHERE itemno=1
ORDER BY recipeno DESC;

/** 레시피 조회 */
SELECT recipeno, itemno, title, article, recom, cnt, replycnt, passwd, word, rdate, file1,file1saved, thumb1, size1, youtube, ingredient, review, star
FROM recipe
WHERE recipeno = 6;

/** 레시피 검색 목록 */
SELECT recipeno, itemno, title, article, recom, cnt, replycnt, passwd, word, rdate, file1,file1saved, thumb1, size1, youtube, ingredient, review, star
FROM recipe
WHERE itemno=1 AND (UPPER(title) LIKE '%' || UPPER('레시피') || '%' 
                                              OR UPPER(article) LIKE '%' || UPPER('레시피') || '%' 
                                              OR UPPER(word) LIKE '%' || UPPER('레시피') || '%')
ORDER BY recipeno DESC;

/** 레시피 검색 갯수 */
SELECT COUNT(*) as cnt
FROM recipe
WHERE itemno=1 AND  (UPPER(title) LIKE '%' || UPPER('레시피') || '%' 
                                              OR UPPER(article) LIKE '%' || UPPER('레시피') || '%' 
                                              OR UPPER(word) LIKE '%' || UPPER('레시피') || '%');
                                          
/** 레시피 검색 + 페이징 목록 */
SELECT recipeno, itemno, title, article, recom, cnt, replycnt, rdate, file1, file1saved, thumb1, size1, youtube, r
FROM (
            SELECT recipeno, itemno, title, article, recom, cnt, replycnt, rdate, file1, file1saved, thumb1, size1, youtube, rownum as r
            FROM (
                          SELECT recipeno, itemno, title, article, recom, cnt, replycnt, rdate, file1, file1saved, thumb1, size1, youtube
                            FROM recipe
                           WHERE itemno=1 AND (UPPER(title) LIKE '%' || UPPER('레시피') || '%' 
                                                                OR UPPER(article) LIKE '%' || UPPER('레시피') || '%' 
                                                                OR UPPER(word) LIKE '%' || UPPER('레시피') || '%')
                          ORDER BY recipeno DESC
                        )
            )
WHERE r >= 1 AND r <= 3;

/** 글 수정 */
UPDATE recipe
SET title='00', content='00',  word='00'
WHERE recipeno = 6;

/** 글 삭제 */
DELETE FROM recipe
WHERE recipeno=6;

/** 특정 카테고리에 속한 레코드 갯수를 리턴 */
SELECT COUNT(*) as cnt 
FROM recipe 
WHERE itemno=1;

/** 특정 카테고리에 속한 모든 레코드 삭제 */
  DELETE FROM goods
  WHERE itemno=1;
  
  /** 