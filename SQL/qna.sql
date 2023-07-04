DROP TABLE qna;
DROP TABLE qna CASCADE CONSTRAINTS;

CREATE TABLE qna (
    qnano                 NUMBER(10)                                        PRIMARY KEY,
    memberno          NUMBER(10)                 NOT NULL,
    title                       VARCHAR(100)            NOT NULL,
    content            CLOB                               NOT NULL,
    passwd              VARCHAR(30)                         NULL,
    word                   VARCHAR(100)                       NULL,
    mname              VARCHAR(30)              NOT NULL,
    rdate                   DATE                                NOT NULL,
    FOREIGN KEY (memberno) REFERENCES member (memberno) ON DELETE CASCADE
);

COMMENT ON TABLE qna is 'QNA';
COMMENT ON COLUMN qna.qnano is 'QNA 번호';
COMMENT ON COLUMN qna.memberno is '회원 번호';
COMMENT ON COLUMN qna.title is 'QNA 제목';
COMMENT ON COLUMN qna.content is 'QNA 내용';
COMMENT ON COLUMN qna.passwd is 'QNA비밀번호';
COMMENT ON COLUMN qna.word is '검색단어';
COMMENT ON COLUMN qna.mname is 'QNA 작성자';
COMMENT ON COLUMN qna.rdate is 'QNA 등록일';


DROP SEQUENCE qna_seq;

CREATE SEQUENCE qna_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

INSERT INTO qna (qnano, memberno, title, content, passwd, rdate)
VALUES (qna_seq.nextval, 1, '질문', '내용', '1234', sysdate);

commit;

SELECT qnano, memberno, title, content, rdate
FROM qna
ORDER BY qnano DESC; 

DELETE FROM qna;
commit;

