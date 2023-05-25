DROP TABLE cart;
ALTER TABLE petcart RENAME TO cart;
CREATE TABLE cart(
        cartno   NUMBER(10)   NOT NULL  PRIMARY KEY,
        memberno NUMBER(10)   NOT NULL,
        goodsno  NUMBER(10)   NOT NULL,
        cnt      NUMBER(10)    DEFAULT 0		 NOT NULL, 
        price    NUMBER(10)    NOT NULL,
        rdate    DATE NOT NULL,
    FOREIGN KEY(memberno)  REFERENCES member(membero),
    FOREIGN KEY(goodsno)    REFERENCES goods(goodsno)
);

COMMENT ON TABLE  cart is '장바구니';
COMMENT ON COLUMN cart.cartno is '장바구니번호';
COMMENT ON COLUMN cart.memberno is '회원번호';
COMMENT ON COLUMN cart.goodsno is '상품번호';
COMMENT ON COLUMN cart.cnt is '수량';
COMMENT ON COLUMN cart.price is '가격';
COMMENT ON COLUMN cart.rdate is '날짜';

COMMENT ON COLUMN cart.goodsno is '상품번호';

DROP SEQUENCE cart_seq;

CREATE SEQUENCE cart_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- 장바구니 담기
INSERT INTO cart(cartno,memberno,goodsno, cnt, price,rdate)
VALUES(cart_seq.nextval,1,1,1,sysdate);


-- 장바구니 전체 목록
SELECT cartno, amount, price, memberno, goodsno
FROM petcart
ORDER BY cartno  ASC;
commit;

-- 모든 레코드 삭제
DELETE FROM petcart;
commit;

-- UPDATE
UPDATE petcart SET amount='2' WHERE cartno=2;
commit;
SELECT * FROM petcart;

-- 삭제
DELETE FROM petcart
WHERE cartno = 1;
commit;

DELETE FROM petcontents
WHERE petcateno=12 AND petcontentsno <= 41;

commit;