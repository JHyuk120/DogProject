 /**********************************/
/* Table Name: 주문상세 */
/**********************************/
DROP TABLE detail CASCADE CONSTRAINTS;

CREATE TABLE detail(
        detailno                     NUMBER(10)         NOT NULL         PRIMARY KEY,
        memberno                        NUMBER(10)        NOT NULL ,
        payno                     NUMBER(10)         NOT NULL,
        goodsno                        NUMBER(10)        NOT NULL ,
        cnt                                   NUMBER(5)         DEFAULT 1         NOT NULL,
        tot                                   NUMBER(10)         DEFAULT 0         NOT NULL,
        stateno                               NUMBER(1)         DEFAULT 0         NOT NULL,
        rdate                                 DATE         NOT NULL,
  FOREIGN KEY (payno) REFERENCES pay (payno),
  FOREIGN KEY (memberno) REFERENCES MEMBER (memberno),
  FOREIGN KEY (goodsno) REFERENCES GOODS (goodsno)
);

COMMENT ON TABLE detail is '주문상세';
COMMENT ON COLUMN detail.detailno is '주문상세번호';
COMMENT ON COLUMN detail.MEMBERNO is '회원 번호';
COMMENT ON COLUMN detail.payno is '주문 번호';
COMMENT ON COLUMN detail.GOODSNO is '컨텐츠 번호';
COMMENT ON COLUMN detail.cnt is '수량';
COMMENT ON COLUMN detail.tot is '합계';
COMMENT ON COLUMN detail.stateno is '주문상태';
COMMENT ON COLUMN detail.rdate is '주문날짜';

DROP SEQUENCE detail_seq;
CREATE SEQUENCE detail_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

-- 등록  
-- 배송 상태(stateno):  1: 결재 완료, 2: 상품 준비중, 3: 배송 시작, 4: 배달중, 5: 오늘 도착, 6: 배달 완료
-- FK(사전에 레코드가 등록되어 있어야함): memberno, payno, goodsno
-- 예) 3번 회원이 4번 결재를 했으며 구입 상품은 1번인 경우: 3, 4, 1
INSERT INTO detail(detailno, memberno, payno, goodsno, cnt, tot, stateno, rdate)
VALUES (detail_seq.nextval, 3, 4, 1, 1, 10000, 1, sysdate);

commit; 


-- 전체 목록
SELECT d.detailno, d.memberno, d.payno, d.goodsno, d.cnt, d.tot, d.stateno, d.rdate, g.gname
FROM detail d, goods g
WHERE d.goodsno = g.goodsno
ORDER BY detailno DESC;

--회원별 목록
SELECT detailno, memberno, payno, goodsno, cnt, tot, stateno, rdate
FROM detail
WHERE memberno=2
ORDER BY detailno DESC;

--배송상태 변경
update detail set stateno = stateno + 1
where detailno = 1;


-- 수정: 개발 안함.


-- 삭제
DELETE FROM detail
WHERE memberno=1;

commit;
  