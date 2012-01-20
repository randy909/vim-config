-- this script is used by VoraX to execute a query using the vertical columns layout.
-- it expects one parameter, the query to be executed without the end delimitator and
-- with all quotes doubled.

set echo off feedback off ver off
set serveroutput on
DECLARE
  l_query         varchar2(32767) := '&1';
  l_NULLAs        varchar2(32) := '';
  l_theCursor     integer default dbms_sql.open_cursor;
  l_columnValue   varchar2(4000);
  l_blobValue     blob;
  l_status        integer;
  l_descTbl       dbms_sql.desc_tab;
  l_colCnt        number;
  l_cs            varchar2(255);
  l_date_fmt      varchar2(255);
  l_RowCount      pls_integer:=0;
BEGIN
  -- remove the end delimitator

  dbms_sql.parse(l_theCursor, l_query, dbms_sql.native );
  dbms_sql.describe_columns(l_theCursor, l_colCnt, l_descTbl);

-- Define all columns to be cast to varchar2s. We are just printing them out.
  for i in 1 .. l_colCnt loop
    if l_descTbl(i).col_type=113 then
      dbms_sql.define_column(l_theCursor, i, l_blobValue);
    else
      dbms_sql.define_column(l_theCursor, i, l_columnValue, 4000);
    end if;
  end loop;

-- Execute the query, so we can fetch.
  l_status := dbms_sql.execute(l_theCursor);

-- Loop and print out each column on a separate line.
-- dbms_output prints only 255 characters/line so only show the first 200 characters.
  while dbms_sql.fetch_rows(l_theCursor)>0 loop
    l_RowCount := l_RowCount+1;
    dbms_output.put_line('Row #' || L_RowCount || ':');
    for i in 1 .. l_colCnt loop
      if l_descTbl(i).col_type=113 then
        l_columnValue := '<BLOB>';
      else
        dbms_sql.column_value(l_theCursor, i, l_columnValue );
      end if;
      dbms_output.put_line(rpad(l_descTbl(i).col_name, 30) || ': ' || substr(nvl(l_columnValue, l_NULLAs), 1, 200));
    end loop;
    dbms_output.put_line( '-----------------' );
  end loop;
 dbms_output.put_line(l_RowCount || ' rows selected.');

 dbms_sql.close_cursor(l_theCursor);

exception
 when others then
  dbms_sql.close_cursor(l_theCursor);
  raise;
end;
/


