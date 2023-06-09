DROP TABLE recom;

CREATE TABLE recom(
    recomno                     NUMBER(10)     NOT NULL    PRIMARY KEY,
    memberno                       NUMBER(10)    NOT NULL ,
    recipeno                          NUMBER(10)    NOT NULL ,
    haddu                              CHAR(1)                 DEFAULT 'N'     NOT NULL,
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO),
  FOREIGN KEY (RECIPENO) REFERENCES RECIPE (RECIPENO)
);

COMMENT ON TABLE recom is '좋아요';
COMMENT ON COLUMN recom.recomno is '좋아요 번호';
COMMENT ON COLUMN recom.MEMBERNO is '회원 번호';
COMMENT ON COLUMN recom.recipeno is '레시피 번호';
COMMENT ON COLUMN recom.haddu is '하뚜';


DROP SEQUENCE recom_seq;
CREATE SEQUENCE recom_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;    
  
  commit;
  
  select count(haddu) from recom where haddu = 'N';
  
  update recom set haddu = 'Y' where recipeno = 9;
  update recom set haddu = 'N' where recipeno = 9;
  
INSERT INTO recom(recomno, memberno, recipeno, haddu)
VALUES (recom_seq.nextval, 7, 9, 'N');

select haddu from recom;