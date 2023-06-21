DROP TABLE item;
DROP TABLE item CASCADE CONSTRAINTS;

CREATE TABLE item(
itemno                         NUMBER(10)  NOT NULL  PRIMARY KEY,
item                           VARCHAR2(30)  NOT NULL,
cnt                            NUMBER(7)  DEFAULT 0  NOT NULL,
seqno                        		NUMBER(10)		     DEFAULT 0		 NOT NULL,
visible                             CHAR(1)                 DEFAULT 'N'     NOT NULL
);

COMMENT ON TABLE item is '아이템';
COMMENT ON COLUMN item.itemno is '품목 번호';
COMMENT ON COLUMN item.item is '품목';
COMMENT ON COLUMN item.cnt is '관련 자료수';
COMMENT ON COLUMN item.seqno is '순서';
COMMENT ON COLUMN item.visible is '출력 모드';

DROP SEQUENCE item_seq;

CREATE SEQUENCE item_seq
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;  

commit;

-- create
INSERT INTO item(itemno, item, cnt, seqno)
VALUES (item_seq.nextval, 큐브형, 0, 1);
   
-- list all    
select itemno, item, cnt, seqno, visible
from item
order by seqno ASC;

--read
select itemno, item, cnt, seqno, visible
from item
where itemno = 1 ;

-- update
UPDATE item
SET item=개껌류, seqno = 3
WHERE itemno=1;

-- delete
delete from item
where itemno=1;

-- update_seqno_decrease, increase
update item
set seqno = seqno - 1   -- seqno = seqno + 1
where itemno = 1;

-- update_visible_y, n
update item
set visible='Y'    -- 'N'
where itemno=1;

-- list_all_y
 SELECT itemno, item, cnt, seqno, visible
FROM item
where visible='Y'
ORDER BY seqno ASC;

-- update_cnt_add,   sub
update item
set cnt = cnt + 1    -- cnt = cnt - 1
where itemno = 1;
