
--@?/sqlplus/admin/plustrce.sql
--GRANT plustrace TO dmuser;

SET LINESIZE 200
SET TIMING OFF
SET AUTOTRACE OFF

-- JOB MAX 100M=10^8
DROP TABLE job;
CREATE TABLE job (
  job_id    NUMBER(9)
, age       NUMBER(2)
, salary    NUMBER(2)
, location  NUMBER(2)
, CONSTRAINT pk_job PRIMARY KEY (job_id)
);
DROP TABLE job_skill;
CREATE TABLE job_skill (
  job_id NUMBER(9)
, skill  NUMBER(2)
);

-- PERSON MAX 1M=10^6
DROP TABLE person;
CREATE TABLE person (
  person_id NUMBER(9)
, age       NUMBER(2)
, salary    NUMBER(2)
, location  NUMBER(2)
, CONSTRAINT pk_person PRIMARY KEY (person_id)
);
DROP TABLE person_skill;
CREATE TABLE person_skill (
  person_id NUMBER(9)
, skill     NUMBER(2)
);

SET TIMING ON

TRUNCATE TABLE job;
DECLARE
  age      NUMBER(2);
  salary   NUMBER(2);
  location NUMBER(2);
BEGIN
  FOR i IN 1..10000 LOOP
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO age      FROM DUAL;
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO salary   FROM DUAL;
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO location FROM DUAL;
    INSERT INTO job VALUES (
      i, age, salary, location
    );
  END LOOP;
END;
/

TRUNCATE TABLE job_skill;
DECLARE
  skill NUMBER(2);
BEGIN
  FOR i IN 1..10000 LOOP
    FOR j IN 1..5 LOOP
      SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO skill FROM DUAL;
      INSERT INTO job_skill VALUES (
        i, skill
      );
    END LOOP;
  END LOOP;
END;
/

TRUNCATE TABLE person;
DECLARE
  age      NUMBER(2);
  salary   NUMBER(2);
  location NUMBER(2);
BEGIN
  FOR i IN 1..10000 LOOP
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO age      FROM DUAL;
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO salary   FROM DUAL;
    SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO location FROM DUAL;
    INSERT INTO person VALUES (
      i, age, salary, location
    );
  END LOOP;
END;
/

TRUNCATE TABLE person_skill;
DECLARE
  skill NUMBER(2);
BEGIN
  FOR i IN 1..10000 LOOP
    FOR j IN 1..10 LOOP
      SELECT FLOOR(DBMS_RANDOM.VALUE(0, 10)) INTO skill FROM DUAL;
      INSERT INTO person_skill VALUES (
        i, skill
      );
    END LOOP;
  END LOOP;
END;
/

SET ECHO ON

SELECT COUNT(*) FROM job;
SELECT COUNT(*) FROM person;
SELECT COUNT(*) FROM job_skill;
SELECT COUNT(*) FROM person_skill;

SET autotrace ON EXPLAIN

SELECT person.person_id, COUNT(*)
FROM job, job_skill, person, person_skill
WHERE
    job.job_id       = 1234
AND job.age          = person.age
AND job.salary       = person.salary
AND job.location     = person.location
AND job.job_id       = job_skill.job_id
AND person.person_id = person_skill.person_id
AND job_skill.skill  = person_skill.skill
GROUP BY person.person_id
ORDER BY COUNT(*) DESC
;
