DROP TABLE recipe CASCADE CONSTRAINTS;
DROP TABLE recipe;

CREATE TABLE recipe(
        recipeno            NUMBER(10)      NOT NULL         PRIMARY KEY,
        adminno             NUMBER(10)      NOT NULL , -- FK
        cateno              NUMBER(10)      NOT NULL , -- FK
        title               VARCHAR2(50)    NOT NULL,
        article             CLOB            NOT NULL,
        recom               NUMBER(7)       DEFAULT 0         NOT NULL,
        cnt                 NUMBER(7)       DEFAULT 0         NOT NULL,
        replycnt            NUMBER(7)       DEFAULT 0         NOT NULL,
        passwd              VARCHAR2(15)    NOT NULL,
        word                VARCHAR2(100)   NULL ,
        rdate               DATE            NOT NULL,
        dogphoto            VARCHAR(100)    NULL,  -- 원본 파일명 image
        dogphotosaved       VARCHAR(100)    NULL,  -- 저장된 파일명, image
        recipephoto         VARCHAR(100)    NULL,  -- 원본 파일명 image
        recipephotosaved    VARCHAR(100)    NULL,  -- 저장된 파일명, image
        thumb1              VARCHAR(100)    NULL,   -- preview image
        size1               NUMBER(10)      DEFAULT 0 NULL,  -- 파일 사이즈
        price               NUMBER(10)      DEFAULT 0 NULL,  
        dc                  NUMBER(10)      DEFAULT 0 NULL,  
        saleprice           NUMBER(10)      DEFAULT 0 NULL,  
        point               NUMBER(10)      DEFAULT 0 NULL,  
        salecnt             NUMBER(10)      DEFAULT 0 NULL,
        ingredients         CLOB            NOT NULL,
        review              CLOB            NOT NULL,
        star rating         NUMBER(5)       DEFAULT 0         NOT NULL
   
);
COMMENT ON TABLE recipe is '레시피';
COMMENT ON COLUMN recipe.recipeno is '레시피 번호';
COMMENT ON COLUMN recipe.adminno is '관리자 번호';
COMMENT ON COLUMN recipe.cateno is '카테고리 번호';
COMMENT ON COLUMN recipe.title is '제목';
COMMENT ON COLUMN recipe.article is '내용';
COMMENT ON COLUMN recipe.recom is '추천수';
COMMENT ON COLUMN recipe.cnt is '조회수';
COMMENT ON COLUMN recipe.replycnt is '댓글수';
COMMENT ON COLUMN recipe.passwd is '패스워드';
COMMENT ON COLUMN recipe.word is '검색어';
COMMENT ON COLUMN recipe.rdate is '등록일';
COMMENT ON COLUMN recipe.file1 is '메인 이미지';
COMMENT ON COLUMN recipe.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN recipe.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN recipe.size1 is '메인 이미지 크기';
COMMENT ON COLUMN recipe.price is '정가';
COMMENT ON COLUMN recipe.dc is '할인률';
COMMENT ON COLUMN recipe.saleprice is '판매가';
COMMENT ON COLUMN recipe.point is '포인트';
COMMENT ON COLUMN recipe.salecnt is '수량';


