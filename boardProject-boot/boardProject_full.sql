CREATE TABLE "MEMBER" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"MEMBER_EMAIL"	NVARCHAR2(50)		NOT NULL,
	"MEMBER_PW"	NVARCHAR2(100)		NOT NULL,
	"MEMBER_NICKNAME"	NVARCHAR2(10)		NOT NULL,
	"MEMBER_TEL"	CHAR(11)		NOT NULL,
	"MEMBER_ADDRESS"	NVARCHAR2(300)		NULL,
	"PROFILE_IMG"	VARCHAR2(300)		NULL,
	"ENROLL_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"AUTHORITY"	NUMBER	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MEMBER_NO" IS '회원 번호(PK)';

COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL" IS '회원 이메일(ID 역할)';

COMMENT ON COLUMN "MEMBER"."MEMBER_PW" IS '회원 비밀번호(암호화)';

COMMENT ON COLUMN "MEMBER"."MEMBER_NICKNAME" IS '회원 닉네임';

COMMENT ON COLUMN "MEMBER"."MEMBER_TEL" IS '회원 전화 번호';

COMMENT ON COLUMN "MEMBER"."MEMBER_ADDRESS" IS '회원 주소';

COMMENT ON COLUMN "MEMBER"."PROFILE_IMG" IS '프로필 이미지';

COMMENT ON COLUMN "MEMBER"."ENROLL_DATE" IS '회원 가입일';

COMMENT ON COLUMN "MEMBER"."MEMBER_DEL_FL" IS '탈퇴 여부(Y,N)';

COMMENT ON COLUMN "MEMBER"."AUTHORITY" IS '권한(1:일반, 2:관리자)';

CREATE TABLE "UPLOAD_FILE" (
	"FILE_NO"	NUMBER		NOT NULL,
	"FILE_PATH"	VARCHAR2(500)		NOT NULL,
	"FILE_ORIGINAL_NAME"	VARCAHR2(300)		NOT NULL,
	"FILE_RENAME"	VARCHAR2(100)		NOT NULL,
	"FILE_UPLOAD_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "UPLOAD_FILE"."FILE_NO" IS '파일 번호(PK)';

COMMENT ON COLUMN "UPLOAD_FILE"."FILE_PATH" IS '파일 요청 경로';

COMMENT ON COLUMN "UPLOAD_FILE"."FILE_ORIGINAL_NAME" IS '파일 원본명';

COMMENT ON COLUMN "UPLOAD_FILE"."FILE_RENAME" IS '파일 변경명';

COMMENT ON COLUMN "UPLOAD_FILE"."FILE_UPLOAD_DATE" IS '업로드 날짜';

COMMENT ON COLUMN "UPLOAD_FILE"."MEMBER_NO" IS '업로드한 회원 번호';


-------------------------------------------

/* 게시판 테이블 생성 */
CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_TITLE"	NVARCHAR2(100)		NOT NULL,
	"BOARD_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"BOARD_WRITE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"BOARD_UPDATE_DATE"	DATE		NULL,
	"READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"BOARD_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"BOARD_CODE"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글 번호(PK)';

COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '게시글 제목';

COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '게시글 내용';

COMMENT ON COLUMN "BOARD"."BOARD_WRITE_DATE" IS '게시글 작성일';

COMMENT ON COLUMN "BOARD"."BOARD_UPDATE_DATE" IS '게시글 마지막 수정일';

COMMENT ON COLUMN "BOARD"."READ_COUNT" IS '조회수';

COMMENT ON COLUMN "BOARD"."BOARD_DEL_FL" IS '게시글 삭제 여부(Y/N)';

COMMENT ON COLUMN "BOARD"."BOARD_CODE" IS '게시판 종류 코드 번호';

COMMENT ON COLUMN "BOARD"."MEMBER_NO" IS '작성한 회원 번호(FK)';


/* 게시판 종류 테이블 생성 */
CREATE TABLE "BOARD_TYPE" (
	"BOARD_CODE"	NUMBER		NOT NULL,
	"BOARD_NAME"	NVARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "BOARD_TYPE"."BOARD_CODE" IS '게시판 종류 코드 번호';

COMMENT ON COLUMN "BOARD_TYPE"."BOARD_NAME" IS '게시판명';


/* 게시글 좋아요 테이블 생성 */
CREATE TABLE "BOARD_LIKE" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD_LIKE"."MEMBER_NO" IS '회원 번호(PK)';

COMMENT ON COLUMN "BOARD_LIKE"."BOARD_NO" IS '게시글 번호(PK)';


/* 게시글 이미지 테이블 생성 */
CREATE TABLE "BOARD_IMG" (
	"IMG_NO"	NUMBER		NOT NULL,
	"IMG_PATH"	VARCHAR2(200)		NOT NULL,
	"IMG_ORIGINAL_NAME"	NVARCHAR2(50)		NOT NULL,
	"IMG_RENAME"	NVARCHAR2(50)		NOT NULL,
	"IMG_ORDER"	NUMBER		NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);


COMMENT ON COLUMN "BOARD_IMG"."IMG_NO" IS '이미지 번호(PK)';

COMMENT ON COLUMN "BOARD_IMG"."IMG_PATH" IS '이미지 요청 경로';

COMMENT ON COLUMN "BOARD_IMG"."IMG_ORIGINAL_NAME" IS '이미지 원본명';

COMMENT ON COLUMN "BOARD_IMG"."IMG_RENAME" IS '이미지 변경명';

COMMENT ON COLUMN "BOARD_IMG"."IMG_ORDER" IS '이미지 순서';

COMMENT ON COLUMN "BOARD_IMG"."BOARD_NO" IS '게시글 번호(PK)';

/* 댓글 테이블 생성 */
CREATE TABLE "COMMENT" (
	"COMMENT_NO"	NUMBER		NOT NULL,
	"COMMENT_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"COMMENT_WRITE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"COMMENT_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PARENT_COMMENT_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "COMMENT"."COMMENT_NO" IS '댓글 번호(PK)';

COMMENT ON COLUMN "COMMENT"."COMMENT_CONTENT" IS '댓글 내용';

COMMENT ON COLUMN "COMMENT"."COMMENT_WRITE_DATE" IS '댓글 작성일';

COMMENT ON COLUMN "COMMENT"."COMMENT_DEL_FL" IS '댓글 삭제 여부(Y/N)';

COMMENT ON COLUMN "COMMENT"."BOARD_NO" IS '게시글 번호(PK)';

COMMENT ON COLUMN "COMMENT"."MEMBER_NO" IS '회원 번호(PK)';

COMMENT ON COLUMN "COMMENT"."PARENT_COMMENT_NO" IS '부모 댓글 번호';


--------------------- PK -----------------------

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEMBER_NO"
);

ALTER TABLE "UPLOAD_FILE" ADD CONSTRAINT "PK_UPLOAD_FILE" PRIMARY KEY (
	"FILE_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_NO"
);

ALTER TABLE "BOARD_TYPE" ADD CONSTRAINT "PK_BOARD_TYPE" PRIMARY KEY (
	"BOARD_CODE"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "PK_BOARD_LIKE" PRIMARY KEY (
	"MEMBER_NO",
	"BOARD_NO"
);

ALTER TABLE "BOARD_IMG" ADD CONSTRAINT "PK_BOARD_IMG" PRIMARY KEY (
	"IMG_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "PK_COMMENT" PRIMARY KEY (
	"COMMENT_NO"
);

-------------------- FK -------------------------


ALTER TABLE "UPLOAD_FILE" ADD CONSTRAINT "FK_MEMBER_TO_UPLOAD_FILE_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);



ALTER TABLE "BOARD" ADD CONSTRAINT "FK_BOARD_TYPE_TO_BOARD_1" FOREIGN KEY (
	"BOARD_CODE"
)
REFERENCES "BOARD_TYPE" (
	"BOARD_CODE"
);



ALTER TABLE "BOARD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);



ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_LIKE_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);



ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_BOARD_TO_BOARD_LIKE_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);


ALTER TABLE "BOARD_IMG" ADD CONSTRAINT "FK_BOARD_TO_BOARD_IMG_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);


ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_BOARD_TO_COMMENT_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);


ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_MEMBER_TO_COMMENT_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);


ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_COMMENT_TO_COMMENT_1" FOREIGN KEY (
	"PARENT_COMMENT_NO"
)
REFERENCES "COMMENT" (
	"COMMENT_NO"
);


---------------------- CHECK -----------------------

-- 게시글 삭제 여부
ALTER TABLE "BOARD" ADD
CONSTRAINT "BOARD_DEL_CHECK"
CHECK("BOARD_DEL_FL" IN ('Y', 'N') );

-- 댓글 삭제 여부
ALTER TABLE "COMMENT" ADD
CONSTRAINT "COMMENT_DEL_CHECK"
CHECK("COMMENT_DEL_FL" IN ('Y', 'N') );


------------------------------------------------------

/* 게시판 종류(BOARD_TYPE) 추가 */
CREATE SEQUENCE SEQ_BOARD_CODE NOCACHE;

DROP SEQUENCE SEQ_BOARD_CODE;

DROP table "BOARD_TYPE" CASCADE constraints;

INSERT INTO "BOARD_TYPE" VALUES(SEQ_BOARD_CODE.NEXTVAL, '공지 게시판');
INSERT INTO "BOARD_TYPE" VALUES(SEQ_BOARD_CODE.NEXTVAL, '정보 게시판');
INSERT INTO "BOARD_TYPE" VALUES(SEQ_BOARD_CODE.NEXTVAL, '자유 게시판');

COMMIT;

SELECT * FROM "BOARD";

-------------------------------------------------------
/* 게시글 번호 시퀀스 생성 */
CREATE SEQUENCE SEQ_BOARD_NO NOCACHE;


/* 게시판(BOARD) 테이블 샘플 데이터 삽입(PL/SQL)*/


SELECT * FROM "MEMBER";

-- DBMS_RANDOM.VALUE(0,3) : 0.0 이상, 3.0 미만의 난수
-- CEIL( DBMS_RANDOM.VALUE(0,3) ) : 1,2,3 중 하나

-- ALT + X 로 실행
BEGIN
	FOR I IN 1..2000 LOOP
		
		INSERT INTO "BOARD"
		VALUES(SEQ_BOARD_NO.NEXTVAL,
					 SEQ_BOARD_NO.CURRVAL || '번째 게시글',
					 SEQ_BOARD_NO.CURRVAL || '번째 게시글 내용 입니다',
					 DEFAULT, DEFAULT, DEFAULT, DEFAULT,
					 CEIL( DBMS_RANDOM.VALUE(0,3) ), -- BOARD_CODE(게시판종류)
					 1 -- MEMBER_NO(작성회원번호)
		);
		
	END LOOP;
END;

COMMIT;

-- 게시판 종류별 샘플 데이터 삽입 확인
SELECT BOARD_CODE, COUNT(*)
FROM "BOARD"
GROUP BY BOARD_CODE
ORDER BY BOARD_CODE;
----------------------------------------------------



-- 특정 게시판에 삭제되지 않은 게시글 목록 조회
-- 단, 최신글이 제일 위에 존재
-- 몇 초/분/시간 전 또는 YYYY-MM-DD 형식으로 작성일 조회 ex) 16시간전...
-- 24시간이 지나면 2024-04-11형태로 나타나게

-- + 댓글 개수
-- + 좋아요 개수

-- 번호 / 제목 [댓글 개수] / 작성자 닉네임 / 작성일 / 조회수 / 좋아요 개수
-- 상관 서브 쿼리
-- 1) 메일 쿼리 1행 조회
-- 2) 1행 조회 결과를 이용해서 서브쿼리 수행
--    (메인쿼리 모두 조회할 때 까지 반복)

SELECT BOARD_NO, BOARD_TITLE, MEMBER_NICKNAME, READ_COUNT,
	   (SELECT COUNT(*) FROM "COMMENT" C WHERE C.BOARD_NO = B.BOARD_NO) COMMENT_COUNT,
	   (SELECT COUNT(*) FROM BOARD_LIKE L WHERE L.BOARD_NO = B.BOARD_NO) LIKE_COUNT,
	   CASE 
		   WHEN  SYSDATE - BOARD_WRITE_DATE < 1/24/60
		   THEN  FLOOR((SYSDATE - BOARD_WRITE_DATE) * 24 * 60 * 60) || '초 전'
		   WHEN  SYSDATE - BOARD_WRITE_DATE < 1/24
		   THEN  FLOOR((SYSDATE - BOARD_WRITE_DATE) * 24 * 60 ) || '분 전'
		   WHEN  SYSDATE - BOARD_WRITE_DATE < 1
		   THEN  FLOOR((SYSDATE - BOARD_WRITE_DATE) * 24) || '시간 전'		   
		   ELSE TO_CHAR(BOARD_WRITE_DATE, 'YYYY-MM-DD')	   
	   END BOARD_WRITE_DATE	   
FROM BOARD B
JOIN MEMBER USING(MEMBER_NO)
WHERE BOARD_DEL_FL = 'N'
AND BOARD_CODE = 1
ORDER BY BOARD_NO DESC;

-- 현재 시간  - 한시간 전
SELECT SYSDATE - 
TO_DATE('2024-04-21 10:45:30', 'YYYY-MM-DD HH24:MI:SS'))
* 60 *60 *24
FROM DUAL;



SELECT BOARD_WRITE_DATE FROM BOARD;

---------------------------------------------------
-- 부모 댓글 번호 NULL 허용
ALTER TABLE "COMMENT" 
MODIFY PARENT_COMMENT_NO NUMBER NULL;


/* 댓글 번호 시퀀스 생성 */
CREATE SEQUENCE SEQ_COMMENT_NO NOCACHE;



/* 댓글 ("COMMNET") 테이블에 샘플 데이터 추가*/

BEGIN
	FOR I IN 1..2000 LOOP
	
		INSERT INTO "COMMENT"	
		VALUES(
			SEQ_COMMENT_NO.NEXTVAL,
			SEQ_COMMENT_NO.CURRVAL || '번째 댓글 입니다',
			DEFAULT, DEFAULT,
			CEIL( DBMS_RANDOM.VALUE(0, 2000) ), -- 게시글번호
			6, -- 댓글작성회원번호
			NULL -- 부모댓글번호
		);
	END LOOP;
END;
;

COMMIT;

-- 게시글 번호 최소값, 최대값
SELECT MIN(BOARD_NO), MAX(BOARD_NO) FROM "BOARD";

-- 댓글 삽입 확인
SELECT BOARD_NO, COUNT(*) 
FROM "COMMENT"
GROUP BY BOARD_NO
ORDER BY BOARD_NO;


SELECT COUNT(*)
	FROM BOARD
	WHERE BOARD_DEL_FL ='N'
	AND BOARD_CODE = 3;
-----------------------------------------------------

/* BOARD_IMG 테이블용 시퀀스 생성 */
CREATE SEQUENCE SEQ_IMG_NO NOCACHE;

/* BOARD_IMG 테이블에 샘플 데이터 삽입 */
INSERT INTO "BOARD_IMG" VALUES(
	SEQ_IMG_NO.NEXTVAL, '/images/board/', '원본1.jpg', 'test1.jpg', 0, 1960
);

/* 5번째 는 이미지 순서를 말하며 0인경우 썸네일에 해당한다.  
 * 6번째 게시글 번호 */

INSERT INTO "BOARD_IMG" VALUES(
	SEQ_IMG_NO.NEXTVAL, '/images/board/', '원본2.jpg', 'test2.jpg', 1, 1960
);

INSERT INTO "BOARD_IMG" VALUES(
	SEQ_IMG_NO.NEXTVAL, '/images/board/', '원본3.jpg', 'test3.jpg', 2, 1960
);

INSERT INTO "BOARD_IMG" VALUES(
	SEQ_IMG_NO.NEXTVAL, '/images/board/', '원본4.jpg', 'test4.jpg', 3, 1960
);

INSERT INTO "BOARD_IMG" VALUES(
	SEQ_IMG_NO.NEXTVAL, '/images/board/', '원본5.jpg', 'test5.jpg', 4, 1960
);


COMMIT;

SELECT * FROM BOARD_IMG;

DROP TABLE BOARD_IMG;

DROP SEQUENCE SEQ_IMG_NO;

-------------------------------------------------------

/* 좋아요 테이블(BOARD_LIKE) 샘플 데이터 추가 */
INSERT INTO "BOARD_LIKE"
VALUES(1, 1998); -- 1번 회원이 1998번 글에 좋아요를 클릭함

COMMIT;


SELECT * FROM BOARD_TYPE
ORDER BY BOARD_CODE ;


SELECT BOARD_CODE "boardCode", BOARD_NAME "boardName"
	FROM BOARD_TYPE
	ORDER BY BOARD_CODE;
	

------------------------------------------------------------
------------------------------------------------------------

-------------------------------------------------------
/* 게시글 상세 조회 */
SELECT BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_CODE, READ_COUNT,
	MEMBER_NO, MEMBER_NICKNAME, PROFILE_IMG,
	
	TO_CHAR(BOARD_WRITE_DATE, 'YYYY"년" MM"월" DD"일" HH24:MI:SS') BOARD_WRITE_DATE, 
	TO_CHAR(BOARD_UPDATE_DATE, 'YYYY"년" MM"월" DD"일" HH24:MI:SS') BOARD_UPDATE_DATE,
	
	(SELECT COUNT(*)
	 FROM "BOARD_LIKE"
	 WHERE BOARD_NO = 1960) LIKE_COUNT,
	
	(SELECT IMG_PATH || IMG_RENAME
	 FROM "BOARD_IMG"
	 WHERE BOARD_NO = 1960
	 AND   IMG_ORDER = 0) THUMBNAIL

FROM "BOARD"
JOIN "MEMBER" USING(MEMBER_NO)
WHERE BOARD_DEL_FL = 'N'
AND BOARD_CODE = 1
AND BOARD_NO = 1960;


SELECT * FROM BOARD
WHERE  BOARD_NO = 1960 ;

---------------------------------------------


/* 상세조회 되는 게시글의 모든 이미지 조회 */
SELECT *
FROM "BOARD_IMG"
WHERE BOARD_NO = 1960
ORDER BY IMG_ORDER;


---------------------------------------------




COMMIT;


/* 상세조회 되는 게시글의 모든 댓글 조회 */
/*계층형 쿼리*/
SELECT LEVEL, C.* FROM       -->  C.* FROM ~ ▶ 인라인 뷰 : 서브쿼리 이용해서 조회되는 데이터를 하나의 테이블 처럼 사용하는 것
	(SELECT COMMENT_NO, COMMENT_CONTENT,
	    TO_CHAR(COMMENT_WRITE_DATE, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"') COMMENT_WRITE_DATE,
	    BOARD_NO, MEMBER_NO, MEMBER_NICKNAME, PROFILE_IMG, PARENT_COMMENT_NO, COMMENT_DEL_FL
	FROM "COMMENT"
	JOIN MEMBER USING(MEMBER_NO)
	WHERE BOARD_NO = 1960) C
WHERE COMMENT_DEL_FL = 'N'
OR 0 != (SELECT COUNT(*) FROM "COMMENT" SUB
				WHERE SUB.PARENT_COMMENT_NO = C.COMMENT_NO
				AND COMMENT_DEL_FL = 'N')
START WITH PARENT_COMMENT_NO IS NULL
CONNECT BY PRIOR COMMENT_NO = PARENT_COMMENT_NO
ORDER SIBLINGS BY COMMENT_NO
;


/*
 위 내용에 대한 설명..?!
 
--> LEVEL, START WITH  ... 내용이 적혀있으면 게층형 쿼리 
--> PARENT_COMMENT_NO null로 뜨는데, START WITH PARENT_COMMENT_NO IS NULL 이라는 말은  1레벨에 속하는 것이 Null 이라는 뜻

2레벨
PARENT_COMMENT_NO 784이라고 적혀있으면 784라는 코멘트 넘버를 가진 것이 부모다 라는 뜻
이에 대한 내용은 CONNECT BY PRIOR COMMENT_NO = PARENT_COMMENT_NO에 적혀있음.

... 

등 1레벨, 2레벨, 3레벨 등... 계층별로 적혀있는 것을 계층형 쿼리!라고 한다.
정렬기준은 ORDER SIBLINGS BY COMMENT_NO => 같은 레벨끼리 정렬하는데  COMMENT_NO 의 오름차순으로 정리해둔 것이 위 내용이다.

*/

-->  원래는 STS 서비스단에 mapper를 3번 호출하지만 마이바티스의 기능으로 한번에 3가지를 모두 호출하는 방법을 사용하여 불러올 예정!





SELECT BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_CODE, READ_COUNT,
			MEMBER_NO, MEMBER_NICKNAME, PROFILE_IMG,
			TO_CHAR(BOARD_WRITE_DATE, 'YYYY"년" MM"월" DD"일" HH24:MI:SS') BOARD_WRITE_DATE, 
			TO_CHAR(BOARD_UPDATE_DATE, 'YYYY"년" MM"월" DD"일" HH24:MI:SS') BOARD_UPDATE_DATE,
			(SELECT COUNT(*)
			 FROM "BOARD_LIKE"
			 WHERE BOARD_NO = 1960) LIKE_COUNT,
			(SELECT IMG_PATH || IMG_RENAME
			 FROM "BOARD_IMG"
			 WHERE BOARD_NO = 1960
			 AND   IMG_ORDER = 0) THUMBNAIL
		FROM "BOARD"
		JOIN "MEMBER" USING(MEMBER_NO)
		WHERE BOARD_DEL_FL = 'N'
		AND BOARD_CODE = 1
		AND BOARD_NO = 1960
		
		
COMMIT;

-----------------------------------------------------

INSERT INTO BOARD_IMG
(
  SELECT SEQ_IMG_NO.NEXTVAL, '경로1', '원본1','변경1', 1, 2001 FROM DUAL
  UNION
  SELECT SEQ_IMG_NO.NEXTVAL, '경로2', '원본2','변경2', 2, 2001 FROM DUAL
  UNION 
  SELECT SEQ_IMG_NO.NEXTVAL, '경로3', '원본3','변경3', 1, 2001 FROM DUAL
)
-->  Error occurred during SQL query execution
-- 이유: SQL Error [2287] [42000]: ORA-02287: 시퀀스 번호는 이 위치에 사용할 수 없습니다

-- 그래서 함수값을 사용하는 방법으로 호출해보기

INSERT INTO BOARD_IMG
(
  SELECT NEXT_IMG_NO(), '경로1', '원본1','변경1', 1, 2001 FROM DUAL
  UNION
  SELECT NEXT_IMG_NO(), '경로2', '원본2','변경2', 2, 2001 FROM DUAL
  UNION 
  SELECT NEXT_IMG_NO(), '경로3', '원본3','변경3', 3, 2001 FROM DUAL
);

INSERT INTO BOARD_IMG
(
  SELECT NEXT_IMG_NO(), '경로1', '원본1','변경1', 1, 2001 FROM DUAL
  UNION
  SELECT NEXT_IMG_NO(), '경로2', '원본2','변경2', 2, 2001 FROM DUAL
  UNION 
  SELECT NEXT_IMG_NO(), '경로3', '원본3','변경3', 3, 2001 FROM DUAL
);

DELETE BOARD_IMG;


SELECT *FROM BOARD_IMG;

-- SEQ_IMG_NO 시퀀스의 다음 값을 반환하는 함수 생성
CREATE OR REPLACE FUNCTION NEXT_IMG_NO
-- 반환형
RETURN NUMBER
-- 사용할 변수
IS IMG_NO NUMBER;
BEGIN
	SELECT SEQ_IMG_NO.NEXTVAL
	INTO IMG_NO
	FROM DUAL;
	RETURN IMG_NO;
END;
;
SELECT NEXT_IMG_NO() FROM DUAL;

COMMIT;
----------------------------------------------------------------------

-- 댓글 0개인 BOARD_NO = 2013

INSERT INTO "COMMENT"
VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 댓글1', DEFAULT,DEFAULT, 2013,1,NULL); -- 2003

INSERT INTO "COMMENT"
VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 댓글2', DEFAULT,DEFAULT, 2013,1,NULL); -- 2004

INSERT INTO "COMMENT"
VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 댓글3', DEFAULT,DEFAULT, 2013,1,NULL); -- 2005

SELECT * FROM "COMMENT" ORDER BY COMMENT_NO DESC ;                     

-- 부모 댓글 1의 자식 댓글
INSERT INTO "COMMENT"
VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 1의 자식 1', DEFAULT,DEFAULT, 2013,1,2003); -- 2009

INSERT INTO "COMMENT"
VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 2의 자식 1', DEFAULT,DEFAULT, 2013,1,2004); -- 2010

 --부모 댓글 2의 자식 댓글
INSERT INTO "COMMENT"
VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 2의 자식 1', DEFAULT,DEFAULT, 2013,1,2004); -- 2011

-- 부모 댓글 2의 자식 1의 자식 댓글
INSERT INTO "COMMENT"
VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 2의 자식 1의 자식', DEFAULT,DEFAULT, 2013,1,2011); -- 2012

COMMIT;

SELECT LEVEL, COMMENT_NO, PARENT_COMMENT_NO, COMMENT_CONTENT
FROM "COMMENT"
WHERE BOARD_NO  = 2013

/* 계층형 쿼리 */
-- PARENT_COMMENT_NO 값이 NULL인 행을 부모(LV.1)
START WITH PARENT_COMMENT_NO IS NULL

-- 부모의 COMMENT_NO와 같은 PARENT_COMMENT_NO 가진 행을 자식으로 지정
CONNECT BY PRIOR COMMENT_NO = PARENT_COMMENT_NO

-- 형제(같은 레벨 부모, 자식)들 간의 정렬 순서를 COMMENT_NO 오름차순
ORDER SIBLINGS BY COMMENT_NO;

---------------------------------------------------------------------------

SELECT  LEVEL, C.*FROM
(SELECT COMMENT_NO, COMMENT_CONTENT,
		    TO_CHAR(COMMENT_WRITE_DATE, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"') COMMENT_WRITE_DATE,
		    BOARD_NO, MEMBER_NO, MEMBER_NICKNAME, PROFILE_IMG, PARENT_COMMENT_NO, COMMENT_DEL_FL
		FROM "COMMENT"
		JOIN MEMBER USING(MEMBER_NO)
		WHERE BOARD_NO = 2013) C
WHERE COMMENT_DEL_FL = 'N' -- 현재 댓글이 삭제되지 않았을 때
OR 0 != (SELECT COUNT(*)FROM "COMMENT" SUB
		WHERE SUB.PARENT_COMMENT_NO = C.COMMENT_NO
		AND COMMENT_DEL_FL = 'N')		
START WITH PARENT_COMMENT_NO IS NULL
CONNECT BY PRIOR COMMENT_NO = PARENT_COMMENT_NO
ORDER SIBLINGS BY COMMENT_NO;

UPDATE "COMMENT" SET COMMENT_DEL_FL = 'N'
WHERE COMMENT_NO = 2003;

ROLLBACK;

-- 

UPDATE "COMMENT" SET
COMMENT_DEL_FL = 'Y' 
WHERE COMMENT_NO = 2005;


SELECT * FROM "COMMENT"
WHERE  COMMENT_NO = 2005;



-----------------------------------------------------------------------------------

SELECT * FROM board_img; --NVARCHAR2(50)
SELECT  *FROM MEMBER; -- VARCHAR2(300)

SELECT IMG_RENAME "rename"
FROM BOARD_IMG
UNION
SELECT SUBSTR(PROFILE_IMG,INSTR(PROFILE_IMG,'/',-1)+1) "rename"
FROM MEMBER
WHERE PROFILE_IMG IS NOT NULL;
--[72000]: ORA-12704: 문자 집합이 일치하지 않습니다

-- 둘의 타입이 맞지 않아서 UNION이 되지 않았는데 CAST를 사용해서 캐스팅으로 해결하게 되었다(밑내용) , 한쪽으로 타입을 동일하게 맞춰주먼된다.
------------------------------------->
SELECT CAST(IMG_RENAME AS VARCHAR2(300)) "rename"
FROM BOARD_IMG
UNION
SELECT SUBSTR(PROFILE_IMG,INSTR(PROFILE_IMG,'/',-1)+1) "rename"
FROM MEMBER
WHERE PROFILE_IMG IS NOT NULL;


COMMIT;


SELECT * FROM "USER";