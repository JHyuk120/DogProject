DROP TABLE cart;
-- 제약 조건과 함께 삭제(제약 조건이 있어도 삭제됨, 권장하지 않음.)
DROP TABLE cart CASCADE CONSTRAINTS;

CREATE TABLE cart(
        cartno   NUMBER(10)   NOT NULL  PRIMARY KEY,
        memberno NUMBER(10)   NOT NULL,
        goodsno  NUMBER(10)   NOT NULL,
        cnt      NUMBER(10)    DEFAULT 0		 NOT NULL, 
        rdate    DATE NOT NULL,
    FOREIGN KEY(memberno)  REFERENCES member(memberno),
    FOREIGN KEY(goodsno)    REFERENCES goods(goodsno)
);

select * from cart;

COMMENT ON TABLE  cart is '장바구니';
COMMENT ON COLUMN cart.cartno is '장바구니번호';
COMMENT ON COLUMN cart.memberno is '회원번호';
COMMENT ON COLUMN cart.goodsno is '상품번호';
COMMENT ON COLUMN cart.cnt is '수량';
COMMENT ON COLUMN cart.rdate is '날짜';
COMMENT ON COLUMN cart.goodsno is '상품번호';

DROP SEQUENCE cart_seq;

CREATE SEQUENCE cart_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- goods
select * from goods;

-- member
select memberno, mname FROM member;
select * from member;
select * from admin;

-- 장바구니 담기
INSERT INTO cart(cartno,memberno,goodsno, cnt,rdate)
VALUES(cart_seq.nextval,1,7,1,sysdate);

INSERT INTO cart(cartno,memberno,goodsno, cnt,rdate)
VALUES(cart_seq.nextval,2,8,2,sysdate);

commit;

-- 장바구니 전체 목록
SELECT cartno,memberno,goodsno, cnt,rdate
FROM cart
ORDER BY cartno  ASC;

-- goods join
SELECT c.cartno, g.goodsno, g.gname, g.thumb1, g.price, g.dc, g.saleprice, g.point, c.memberno, c.cnt, c.rdate 
FROM goods g, cart c
WHERE g.goodsno = c.cartno
ORDER BY cartno;

-- 1번 회원의 쇼핑카트 목록
SELECT c.cartno, g.goodsno, g.gname, g.thumb1, g.price, g.dc, g.saleprice, g.point, c.memberno, c.cnt, c.rdate 
FROM goods g, cart c
WHERE (g.goodsno = c.cartno) AND c.memberno=1
ORDER BY cartno;

-- UPDATE
UPDATE cart 
SET cnt='2'
WHERE cartno=1;
commit;

SELECT * FROM cart;

-- 모든 레코드 삭제
DELETE FROM petcart;
commit;

-- 삭제
DELETE FROM cart
WHERE cartno = 1;
commit;
