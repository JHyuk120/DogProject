
DROP TABLE answer;

CREATE TABLE answer(
        answer_no                          NUMBER(10)         NOT NULL         PRIMARY KEY,
        qnano                                   NUMBER(10)         NOT NULL , -- FK
        title                                        VARCHAR(30)       NOT NULL,
        aname                                 VARCHAR(30)       NOT NULL,
        text                                       CLOB                      NOT NULL, 
        rdate                                     DATE                      NOT NULL, 
        passwd                                VARCHAR(30)               NULL,  
        FOREIGN KEY (qnano) REFERENCES qna (qnano) ON DELETE CASCADE
);

COMMENT ON TABLE answer is 'QNA답글';
COMMENT ON COLUMN answer.answer_no is '답글 번호';
COMMENT ON COLUMN answer.qnano is 'QNA 번호';
COMMENT ON COLUMN answer.title is '제목';
COMMENT ON COLUMN answer.aname is '답변자';
COMMENT ON COLUMN answer.text is '답글 내용';
COMMENT ON COLUMN answer.passwd is 'QNA비밀번호';
COMMENT ON COLUMN answer.rdate is '답글 등록일';

DROP SEQUENCE answer_seq;

CREATE SEQUENCE answer_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  

INSERT INTO answer (answer_no, qnano, title, text, passwd, rdate)
VALUES (answer_seq.nextval, 1,'제목', '답변', '1234', sysdate);

SELECT * FROm answer;