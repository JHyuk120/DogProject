/**********************************/
/* Table Name: 관리자 */
/**********************************/
DROP TABLE admin CASCADE CONSTRAINTS;

DROP TABLE admin;

CREATE TABLE admin(
    adminno    NUMBER(10)    NOT NULL,
    id         VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
    passwd     VARCHAR(15)   NOT NULL, -- 패스워드, 영숫자 조합
    mname      VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
    mdate      DATE          NOT NULL, -- 가입일    
    PRIMARY KEY (adminno)              -- 한번 등록된 값은 중복 안됨
);

COMMENT ON TABLE admin is '관리자';
COMMENT ON COLUMN admin.adminno is '관리자 번호';
COMMENT ON COLUMN admin.id is '아이디';
COMMENT ON COLUMN admin.PASSWD is '패스워드';
COMMENT ON COLUMN admin.MNAME is '성명';
COMMENT ON COLUMN admin.MDATE is '가입일';

DROP SEQUENCE admin_seq;

CREATE SEQUENCE admin_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

INSERT INTO admin(adminno, id, passwd, mname, mdate)
VALUES(admin_seq.nextval, 'admin1', '1234', '관리자1', sysdate);

INSERT INTO admin(adminno, id, passwd, mname, mdate)
VALUES(admin_seq.nextval, 'admin2', '1234', '관리자2', sysdate, 1);

INSERT INTO admin(adminno, id, passwd, mname, mdate, grade)
VALUES(admin_seq.nextval, 'admin3', '1234', '관리자3', sysdate, 1);

commit;

SELECT * FROM admin;