DROP TABLE detail;

CREATE TABLE detail(
        detailno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        payno                               NUMBER(10)         NOT NULL,  --FK
        goodsno                           NUMBER(10)         NOT NULL , -- FK
        cnt                                   NUMBER(5)         NOT NULL , -- 수량
        tot                                   NUMBER(10)         NOT NULL , -- 합계
        comp                                CHAR(1)                 DEFAULT 'N'     NOT NULL,  -- 배송완료 'N' 'I' 'Y'
        rdate                                 DATE               NOT NULL, -- 주문 날짜
        FOREIGN KEY (payno) REFERENCES pay (payno),
        FOREIGN KEY (goodsno) REFERENCES goods (goodsno)
);

COMMENT ON TABLE detail is '상세 주문';
COMMENT ON COLUMN detail.detailno is '상세 주문 번호';
COMMENT ON COLUMN detail.payno is '결제 번호';
COMMENT ON COLUMN detail.goodsno is '콘텐츠 번호';
COMMENT ON COLUMN DETAIL.cnt is '수량';
COMMENT ON COLUMN DETAIL.tot is '합계';
COMMENT ON COLUMN DETAIL.comp is '배송 상태';
COMMENT ON COLUMN DETAIL.rdate is '주문 날짜';

DROP SEQUENCE detail_seq;

CREATE SEQUENCE detail_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;      
  
  commit;
  
  select * from detail;
  