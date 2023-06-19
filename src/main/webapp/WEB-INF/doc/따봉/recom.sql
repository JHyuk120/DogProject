DROP TABLE recom;

CREATE TABLE recom(
    recomno                         NUMBER(10)      NOT NULL    PRIMARY KEY,
    memberno                       NUMBER(10)    NOT NULL ,
    recipeno                          NUMBER(10)    NOT NULL ,
    rdate                              DATE     NOT NULL, 
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO),
  FOREIGN KEY (RECIPENO) REFERENCES RECIPE (RECIPENO)
);

COMMENT ON TABLE recom is '좋아요';
COMMENT ON COLUMN recom.RECOMNO is '좋아요 번호';
COMMENT ON COLUMN recom.MEMBERNO is '회원 번호';
COMMENT ON COLUMN recom.recipeno is '레시피 번호';
COMMENT ON COLUMN recom.rdate is '좋아요 날짜';


DROP SEQUENCE recom_seq;
CREATE SEQUENCE recom_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;    
  
  commit;
  
  select count(haddu) from recom where haddu = 1 and recipeno=9;
  
  update recom set haddu = 1 where recipeno = 18;
  update recom set haddu = 0 where recipeno = 18;
  
INSERT INTO recom(recomno, memberno, recipeno, haddu)
VALUES (recom_seq.nextval, 7, 13, 0);

INSERT INTO recom(memberno, recipeno, haddu)
VALUES ( 2, 13, 1);

select haddu from recom;
select * from recom;
select * from recipe;
select * from member;

select count(haddu) from recom where haddu = 1 AND recipeno=18;

delete from recom;


select count(recomno) from recom where recipeno = 18;

--check_cnt
select count(recipeno) from recom where recipeno = 18 AND memberno = 7;

-- delete
delete from recom where memberno = 7;


--adminList
select title, recom, rdate from recipe order by recom desc;
