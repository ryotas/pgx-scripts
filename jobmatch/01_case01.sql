
--@?/sqlplus/admin/plustrce.sql
--GRANT plustrace TO dmuser;

SET LINESIZE 200
SET TIMING ON

-- JOB MAX 100M=10^8
DROP TABLE job;
CREATE TABLE job (
  job_id    NUMBER(9)
, age       NUMBER(2)
, skill     NUMBER(2)
, salary    NUMBER(2)
, location  NUMBER(2)
, CONSTRAINT pk_job PRIMARY KEY (job_id)
);

-- PERSON MAX 1M=10^6
DROP TABLE person;
CREATE TABLE person (
  person_id NUMBER(9)
, age       NUMBER(2)
, skill     NUMBER(2)
, salary    NUMBER(2)
, location  NUMBER(2)
, CONSTRAINT pk_person PRIMARY KEY (person_id)
);

TRUNCATE TABLE job;
DECLARE
  age      NUMBER(2);
  skill    NUMBER(2);
  salary   NUMBER(2);
  location NUMBER(2);
BEGIN
  FOR i IN 1..10000 LOOP
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO age      FROM DUAL;
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO skill    FROM DUAL;
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO salary   FROM DUAL;
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO location FROM DUAL;
    INSERT INTO job VALUES (
      i, age, skill, salary, location
    );
  END LOOP;
END;
/

TRUNCATE TABLE person;
DECLARE
  age      NUMBER(2);
  skill    NUMBER(2);
  salary   NUMBER(2);
  location NUMBER(2);
BEGIN
  FOR i IN 1..10000 LOOP
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO age      FROM DUAL;
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO skill    FROM DUAL;
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO salary   FROM DUAL;
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO location FROM DUAL;
    INSERT INTO person VALUES (
      i, age, skill, salary, location
    );
  END LOOP;
END;
/

SET ECHO ON

SELECT COUNT(*) FROM job;
SELECT COUNT(*) FROM person;

SET autotrace ON EXPLAIN

SELECT COUNT(person.person_id)
FROM job, person
WHERE
    job.job_id   = 1234
AND job.age      = person.age
AND job.skill    = person.skill
AND job.salary   = person.salary
AND job.location = person.location
;
