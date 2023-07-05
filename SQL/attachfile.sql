DROP TABLE attachfile;

CREATE TABLE attachfile(
        attachfileno                  NUMBER(10)                NOT NULL,
        qnano                           NUMBER(10)                NOT NULL,
        fname                           VARCHAR2(100)         NULL,
        fupname                      VARCHAR2(100)         NULL,
        thumb                           VARCHAR2(100)         NULL ,
        fsize                              NUMBER(10)                DEFAULT 0         NOT NULL,
        rdate                             DATE                              NOT NULL,
  FOREIGN KEY (qnano) REFERENCES qna (qnano) ON DELETE CASCADE
);

COMMENT ON TABLE attachfile is '첨부파일';
COMMENT ON COLUMN attachfile.attachfileno is '첨부파일번호';
COMMENT ON COLUMN attachfile.qnano is 'QNA번호';
COMMENT ON COLUMN attachfile.fname is '원본 파일명';
COMMENT ON COLUMN attachfile.fupname is '업로드 파일명';
COMMENT ON COLUMN attachfile.thumb is 'Thumb 파일명';
COMMENT ON COLUMN attachfile.fsize is '파일 사이즈';
COMMENT ON COLUMN attachfile.rdate is '등록일';

DROP SEQUENCE attachfile_seq;
CREATE SEQUENCE attachfile_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
  commit;
  
-- 1) 등록
INSERT INTO attachfile(attachfileno, qnano, fname, fupname, thumb, fsize, rdate)
VALUES(attachfile_seq.nextval, 1, 'samyang.jpg', 'samyang_1.jpg', 'samyang_t.jpg', 1000, sysdate);

INSERT INTO attachfile(attachfileno, qnano, fname, fupname, thumb, fsize, rdate)
VALUES(attachfile_seq.nextval, 1, 'samyang2.jpg', 'samyang2_1.jpg', 'samyang2_t.jpg', 2000, sysdate);
             
INSERT INTO attachfile(attachfileno, qnano, fname, fupname, thumb, fsize, rdate)
VALUES(attachfile_seq.nextval,  1, 'samyang3.jpg', 'samyang3_1.jpg', 'samyang3_t.jpg', 3000, sysdate);        
             
-- 2) 목록( qnano 기준 내림 차순, attachfileno 기준 오르차순)
SELECT attachfileno, qnano, fname, fupname, thumb, fsize, rdate
FROM attachfile
ORDER BY qnano DESC,  attachfileno ASC;

-- 3) 글별 파일 목록(qnano 기준 내림 차순, attachfileno 기준 오르차순
SELECT attachfileno, qnano, fname, fupname, thumb, fsize, rdate
FROM attachfile
WHERE qnano = 1
ORDER BY fname ASC;

-- 4) 하나의 파일 삭제
DELETE FROM attachfile
WHERE attachfileno = 1; 

-- 5) FK qnano 부모키 별 조회
SELECT attachfileno, qnano, fname, fupname, thumb, fsize, rdate
FROM attachfile
WHERE qnano=1;

-- 부모키별 갯수 산출
SELECT COUNT(*) as cnt
FROM attachfile
WHERE qnano=1;

-- 6) FK 부모 테이블별 레코드 삭제
DELETE FROM attachfile
WHERE qnano=1;

-- 7) Contents, Attachfile join
    SELECT c.title, 
               a.attachfileno, a.qnano, a.fname, a.fupname, a.thumb, a.fsize, a.rdate
    FROM contents c, attachfile a
    WHERE c.qnano = a.qnano
    ORDER BY c.qnano DESC,  a.attachfileno ASC;
    
 -- 8) 조회
SELECT attachfileno, qnano, fname, fupname, thumb, fsize, rdate
FROM attachfile
WHERE attachfileno=1;