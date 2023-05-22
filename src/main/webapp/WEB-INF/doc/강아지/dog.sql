DROP TABLE dog;

CREATE TABLE dog(
itemno                         NUMBER(10)  NOT NULL  PRIMARY KEY,
item                           VARCHAR2(30)  NOT NULL,
cnt                            NUMBER(7)  DEFAULT 0  NOT NULL,
seqno                        		NUMBER(10)		     DEFAULT 0		 NOT NULL,
visible                             CHAR(1)                 DEFAULT 'N'     NOT NULL
);

COMMENT ON TABLE dog is '강아지';
COMMENT ON COLUMN dog.itemno is '품목 번호';
COMMENT ON COLUMN dog.item is '품목';
COMMENT ON COLUMN dog.cnt is '관련 자료수';
COMMENT ON COLUMN dog.seqno is '순서';
COMMENT ON COLUMN dog.visible is '출력 모드';

DROP SEQUENCE dog_seq;

CREATE SEQUENCE dog_seq
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;  

INSERT INTO dog (itemno, item, cnt) VALUES(dog_seq.nextval, '큐프형', 0);

update dog set visible = 'Y' where itemno=1;

commit;

SELECT * FROM dog;

select * from admin;