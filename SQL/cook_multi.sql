DROP TABLE cook_multi;

CREATE TABLE cook_multi(
        cookfileno      NUMBER(10)                NOT NULL,
        recipeno        NUMBER(10)                NOT NULL,
        cookfile        VARCHAR2(100)               NULL,
        cookfilesaved   VARCHAR2(100)               NULL,
        thumb           VARCHAR2(100)               NULL ,
        cookfilesize    NUMBER(10)                DEFAULT 0         NULL,
        exp             CLOB            NOT NULL,
  FOREIGN KEY (recipeno) REFERENCES recipe (recipeno)ON DELETE CASCADE
);

COMMENT ON TABLE cook_multi is '첨부파일';
COMMENT ON COLUMN cook_multi.cookfileno is '첨부파일번호';
COMMENT ON COLUMN cook_multi.recipeno is 'recipe번호';
COMMENT ON COLUMN cook_multi.cookfile is '원본 파일명';
COMMENT ON COLUMN cook_multi.cookfilesaved is '업로드 파일명';
COMMENT ON COLUMN cook_multi.thumb is 'Thumb 파일명';
COMMENT ON COLUMN cook_multi.cookfilesize is '파일 사이즈';
COMMENT ON COLUMN cook_multi.exp is '글 여러개';

DROP SEQUENCE cook_multi_seq;
CREATE SEQUENCE cook_multi_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
  commit;
  
-- 1) 등록
INSERT INTO cookfile(cookfileno, recipeno, fname, fupname, thumb, fsize, rdate)
VALUES(cookfile_seq.nextval, 1, 'samyang.jpg', 'samyang_1.jpg', 'samyang_t.jpg', 1000, sysdate);

INSERT INTO cookfile(cookfileno, recipeno, fname, fupname, thumb, fsize, rdate)
VALUES(cookfile_seq.nextval, 1, 'samyang2.jpg', 'samyang2_1.jpg', 'samyang2_t.jpg', 2000, sysdate);
             
INSERT INTO cookfile(cookfileno, recipeno, fname, fupname, thumb, fsize, rdate)
VALUES(cookfile_seq.nextval,  1, 'samyang3.jpg', 'samyang3_1.jpg', 'samyang3_t.jpg', 3000, sysdate);        
             
-- 2) 목록( recipeno 기준 내림 차순, cookfileno 기준 오르차순)
SELECT cookfileno, recipeno, fname, fupname, thumb, fsize, rdate
FROM cookfile
ORDER BY recipeno DESC,  cookfileno ASC;

-- 3) 글별 파일 목록(recipeno 기준 내림 차순, cookfileno 기준 오르차순
SELECT cookfileno, recipeno, fname, fupname, thumb, fsize, rdate
FROM cookfile
WHERE recipeno = 1
ORDER BY fname ASC;

-- 4) 하나의 파일 삭제
DELETE FROM cookfile
WHERE cookfileno = 1; 

-- 5) FK recipeno 부모키 별 조회
SELECT cookfileno, recipeno, fname, fupname, thumb, fsize, rdate
FROM cookfile
WHERE recipeno=1;

-- 부모키별 갯수 산출
SELECT COUNT(*) as cnt
FROM cookfile
WHERE recipeno=1;

-- 6) FK 부모 테이블별 레코드 삭제
DELETE FROM cookfile
WHERE recipeno=1;

-- 7) Contents, cookfile join
    SELECT c.title, 
               a.cookfileno, a.recipeno, a.fname, a.fupname, a.thumb, a.fsize, a.rdate
    FROM contents c, cookfile a
    WHERE c.recipeno = a.recipeno
    ORDER BY c.recipeno DESC,  a.cookfileno ASC;
    
 -- 8) 조회
SELECT cookfileno, recipeno, fname, fupname, thumb, fsize, rdate
FROM cookfile
WHERE cookfileno=1;