DROP TABLE pay;

CREATE TABLE pay(
        payno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        memberno                              NUMBER(10)     NOT NULL , -- FK
        tname         VARCHAR(30)      NOT NULL, -- 성명, 한글 10자 저장 가능
        ttel             VARCHAR(14)      NOT NULL, -- 전화번호
        tzipcode     VARCHAR(5)        NOT NULL, -- 우편번호, 12345
        taddress1    VARCHAR(80)     NOT NULL, -- 주소 1
        taddress2    VARCHAR(50)     NOT NULL, -- 주소 2
        ptype                           NUMBER(1)    DEFAULT 0     NOT NULL,
        amount                            NUMBER(10)     DEFAULT 0     NOT NULL,
        rdate                              DATE     NOT NULL, 
        FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE pay is '결제';
COMMENT ON COLUMN pay.payno is '결제 번호';
COMMENT ON COLUMN pay.memberno is '회원 번호';
COMMENT ON COLUMN PAY.tname is '받는이 성명';
COMMENT ON COLUMN PAY.ttel is '받는이 전화번호';
COMMENT ON COLUMN PAY.tzipcode is '받는이 우편번호';
COMMENT ON COLUMN PAY.TADDRESS1 is '받는이 주소1';
COMMENT ON COLUMN PAY.TADDRESS2 is '받는이 주소2';
COMMENT ON COLUMN pay.ptype is '결재 종류';
COMMENT ON COLUMN pay.amount is '결재금액';
COMMENT ON COLUMN pay.rdate is '주문날짜';

DROP SEQUENCE pay_seq;

CREATE SEQUENCE pay_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;      
  
  commit;
  
  select * from pay;