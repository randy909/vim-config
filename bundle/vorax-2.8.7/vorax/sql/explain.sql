-- This script is invoked by VoraX to get the explain plan for
-- a provided statement. Feel free to change it according to your
-- needs.
--
-- The &1 parameter is the sql script which contains the statement
-- to be explained. All current sqlplus options are saved before
-- and restore after, therefore you may set whatever sqlplus
-- option you want.

-- by default, don't show the query results for the statement.
set termout off

-- we want all statistics available
alter session set statistics_level='ALL';

-- serveroutput must be off in order DBMS_XPLAN to work as
-- expected.
set serveroutput off

-- execute the statement
@&1

-- enable terminal display
set termout on

-- set options so that the plan to look nice
set linesize 200
set pagesize 9999
set heading off
set feedback off

-- show the plan for the last sql
select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));

