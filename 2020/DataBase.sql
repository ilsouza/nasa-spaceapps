/*
Script gerado por Aqua Data Studio 20.6.1-2 em out-04-2020 10:25:47 AM
Banco de Dados: quiz
Esquema: public
Objetos: OBJECT_TYPE, DATATYPE, SEQUENCE, RULE, TABLE, VIEW, MAT_VIEW, PROCEDURE, FUNCTION, INDEX, TRIGGER
*/
DROP TRIGGER "userstrigger" ON "public"."users"
GO
DROP TRIGGER "quizactionstrigger" ON "public"."quiz_action"
GO
DROP TRIGGER "quiztrigger" ON "public"."quiz"
GO
DROP TRIGGER "questionstrigger" ON "public"."questions"
GO
DROP FUNCTION "public"."usersseq" ()
GO
DROP FUNCTION "public"."quizseq" ()
GO
DROP FUNCTION "public"."quizactionsseq" ()
GO
DROP FUNCTION "public"."questionsseq" ()
GO
DROP TABLE "public"."users"
GO
DROP TABLE "public"."quiz_action"
GO
DROP TABLE "public"."quiz"
GO
DROP TABLE "public"."questions"
GO

CREATE TABLE "public"."questions"  ( 
	"que_id"         	integer NOT NULL,
	"que_description"	varchar(1000) NULL,
	"que_01_desc"    	varchar(1000) NULL,
	"que_02_desc"    	varchar(1000) NULL,
	"que_03_desc"    	varchar(1000) NULL,
	"que_04_desc"    	varchar(1000) NULL,
	"que_ro"         	smallint NULL,
	"que_link_yt"    	varchar(200) NULL,
	CONSTRAINT "pk_questions" PRIMARY KEY("que_id")
)
GO
ALTER TABLE "public"."questions" OWNER TO "postgres"
GO
CREATE TABLE "public"."quiz"  ( 
	"qui_id"  	integer NOT NULL,
	"qui_name"	varchar(20) NULL,
	CONSTRAINT "pk_quiz" PRIMARY KEY("qui_id")
)
GO
ALTER TABLE "public"."quiz" OWNER TO "postgres"
GO
CREATE TABLE "public"."quiz_action"  ( 
	"qac_id"     	integer NOT NULL,
	"qac_usr_id" 	integer NULL,
	"qac_qui_id" 	integer NULL,
	"qac_que_id" 	integer NULL,
	"qac_answer" 	smallint NULL,
	"qac_correct"	boolean NULL,
	CONSTRAINT "pk_quiz_action" PRIMARY KEY("qac_id")
)
GO
ALTER TABLE "public"."quiz_action" OWNER TO "postgres"
GO
CREATE TABLE "public"."users"  ( 
	"usr_id"  	integer NOT NULL,
	"usr_name"	varchar(20) NULL,
	CONSTRAINT "pk_user" PRIMARY KEY("usr_id")
)
GO
ALTER TABLE "public"."users" OWNER TO "postgres"
GO
CREATE FUNCTION "public"."questionsseq" () RETURNS trigger AS
$$
    BEGIN
      New.que_id:=nextval('seqquestions');
      Return NEW;
    END;
$$
LANGUAGE 'plpgsql' COST 100
GO
ALTER FUNCTION "public"."questionsseq" () OWNER TO "postgres"
GO
CREATE FUNCTION "public"."quizactionsseq" () RETURNS trigger AS
$$
    BEGIN
      New.qac_id:=nextval('seqquizactions');
      Return NEW;
    END;
$$
LANGUAGE 'plpgsql' COST 100
GO
ALTER FUNCTION "public"."quizactionsseq" () OWNER TO "postgres"
GO
CREATE FUNCTION "public"."quizseq" () RETURNS trigger AS
$$
    BEGIN
      New.qui_id:=nextval('seqquiz');
      Return NEW;
    END;
$$
LANGUAGE 'plpgsql' COST 100
GO
ALTER FUNCTION "public"."quizseq" () OWNER TO "postgres"
GO
CREATE FUNCTION "public"."usersseq" () RETURNS trigger AS
$$
    BEGIN
      New.usr_id:=nextval('sequser');
      Return NEW;
    END;
$$
LANGUAGE 'plpgsql' COST 100
GO
ALTER FUNCTION "public"."usersseq" () OWNER TO "postgres"
GO
CREATE TRIGGER "questionstrigger"
	BEFORE INSERT
	ON "public"."questions"
	FOR EACH ROW
	EXECUTE PROCEDURE "public"."questionsseq"()
GO
CREATE TRIGGER "quiztrigger"
	BEFORE INSERT
	ON "public"."quiz"
	FOR EACH ROW
	EXECUTE PROCEDURE "public"."quizseq"()
GO
CREATE TRIGGER "quizactionstrigger"
	BEFORE INSERT
	ON "public"."quiz_action"
	FOR EACH ROW
	EXECUTE PROCEDURE "public"."quizactionsseq"()
GO
CREATE TRIGGER "userstrigger"
	BEFORE INSERT
	ON "public"."users"
	FOR EACH ROW
	EXECUTE PROCEDURE "public"."usersseq"()
GO

