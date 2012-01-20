" Description: Code completion for VoraX
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:vorax_completion")
  finish
endif

" flag to signal this source was loaded
let s:vorax_completion = 1

" Enable logging
if g:vorax_debug
  silent! call log#init('ALL', ['~/vorax.log'])
  silent! let s:log = log#getLogger(expand('<sfile>:t'))
endif

" sql/plsql/commands keywords
let s:keywords = [ 
                  \ {'word' : '$$PLSQL_LINE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : '$$PLSQL_UNIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : '$ELSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : '$ELSIF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : '$END', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : '$ERROR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : '$IF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : '$THEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AFTER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AGENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AGGREGATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ALL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ALTER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ANY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ARRAY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ASC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUTHID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUTONOMOUS_TRANSACTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AVG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BEFORE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BEGIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BETWEEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BINARY_INTEGER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BLOB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BLOCK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BODY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BOOLEAN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BULK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BULK_EXCEPTIONS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BULK_ROWCOUNT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BYTE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CALL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CALLING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CASE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CAST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHAR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHARACTER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHECK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CLASS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CLOB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CLOSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CLUSTER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COLLECT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMMIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMMITTED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMPILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONNECT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONSTANT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONSTRAINT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONSTRUCTOR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONTEXT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COUNT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CREATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CROSS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CUBE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CURRENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CURRENT_USER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CURRVAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CURSOR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DATABASE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DAY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DECIMAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DECLARE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEFAULT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEFINER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DELETE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEREF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DESC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DETERMINISTIC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISTINCT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DOUBLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EACH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ELSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ELSIF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'END', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ERROR_CODE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ERROR_INDEX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ESCAPE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXCEPTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXCEPTION_INIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXCEPTIONS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXCLUSIVE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXECUTE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXISTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXTEND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXTERNAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FALSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FETCH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FINAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FIRST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FLOAT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FOR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FORALL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FOUND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FROM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FULL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FUNCTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GOTO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GROUP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GROUPING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HASH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HAVING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IMMEDIATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INDEX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INDICES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INNER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSERT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSTANTIABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSTEAD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INTEGER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INTERSECT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INTERVAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INTO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ISOLATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ISOPEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'JAVA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'JOIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LANGUAGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LAST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LEFT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LEVEL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LIBRARY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LIKE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LIMIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOCAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOCK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LONG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOOP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MATCHED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MEMBER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MERGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MINUS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MLSLABEL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MOD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MODE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MONTH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MULTISET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NAME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NAMED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NATURAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NATURALN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NCHAR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NCLOB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NESTED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NEW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NEXT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NEXTVAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOCOPY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOFORCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOTFOUND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOWAIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NULL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NULLS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NUMBER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NUMERIC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NVARCHAR2', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OBJECT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OLD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ON', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ONLY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OPEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OPTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ORDER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OTHERS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OUT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OUTER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OVERRIDING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PACKAGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PARALLEL_ENABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PARAMETERS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PARENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PARTITION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PIPE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PIPELINED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PLS_INTEGER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'POSITIVE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'POSITIVEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRAGMA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRAGMA_RESTRICT_REFERENCES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRECISION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRIOR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PROCEDURE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RAISE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RANGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RAW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'READ', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RECORD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REFERENCING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REPLACE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESOLVE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESOLVER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESOURCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESTRICT_REFERENCES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESULT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RETURN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RETURNING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REVERSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RIGHT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RNDS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RNPS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROLLBACK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROLLUP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROWCOUNT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROWID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROWTYPE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SAMPLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SAVE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SAVEPOINT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SCHEMA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SECOND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SEGMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SELECT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SELF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SERIALIZABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SERIALLY_REUSABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SETS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SHARE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SIBLINGS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SIGNTYPE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SMALLINT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SOURCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SQL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SQLCODE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SQLERRM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STANDARD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'START', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STATEMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STATIC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STDDEV', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STRING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBPARTITION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBTYPE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYS_REFCURSOR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYSDATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'THE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'THEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TIME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TIMESTAMP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRANSACTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRIGGER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRIM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRUST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TYPE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNDER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNIQUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UPDATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UROWID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'USE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'USER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'USING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VALUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VALUES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VARCHAR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VARCHAR2', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VARIABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VARIANCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VARRAY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VARYING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WHEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WHERE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WHILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WITH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WNDS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WNPS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WORK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WRITE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'YEAR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ZONE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ABBR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ABORT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ABS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ACCESS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ACCESSED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ACCOUNT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ACOS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ACTIVATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ADD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ADMIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ADVISE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ALIAS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ALL_ROWS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ALLOCATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ALLOW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ALWAYS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ANALYSIS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ANALYZE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ANCILLARY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ANOVA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ANSI', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ANYSCHEMA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'APPEND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'APPENDCHILDXML', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'APPLY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ARCHIVE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ARCHIVELOG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ARRAYLEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ASCII', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ASCIISTR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ASIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ASM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ASP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ASSOCIATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ATAN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ATAN2', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ATTEMPTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ATTRIBUTE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ATTRIBUTES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUDIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUTHENTICATED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUTHENTICATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUTHORIZATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUTO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUTOALLOCATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUTOEXTEND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUTOMATIC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AUTONOMOUS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AVAILABILITY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AVGX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'AVGY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BACKUP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BASICFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BATCH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BECOME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BEHALF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BFILENAME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BIGFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BINARY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BINDING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BINOMIAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BITAND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BITMAP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BLOCKSIZE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BNF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BOTH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BOUNDS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BUCKET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BUFFER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BUFFER_POOL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'BUILD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CACHE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CACHE_INSTANCES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CANCEL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CANONICAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CARDINALITY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CASCADE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CATEGORY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CEIL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHAINED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHANGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHAR_CS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHARSET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHARTOROWID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHECKBOX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHECKPOINT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHILD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHISQ', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHOOSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CHUNK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CLEAR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CLONE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CLOSE_CACHED_OPEN_CURSORS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CLUSTER_ID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CLUSTER_PROBABILITY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CLUSTER_SET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COALESCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COARSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COBOL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CODE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COEFFICIENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COHENS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COLUMN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COLUMN_VALUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COLUMNS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMBINE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMPACT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMPATIBILITY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMPLETE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMPOSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMPOSITE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMPOSITE_LIMIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMPOUND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMPRESS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COMPUTE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONCAT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONNECT_TIME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONSIDER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONSISTENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONSTRAINTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONTENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONTENTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONTINUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONTROLFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CONVERT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CORE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CORR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CORRUPT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CORRUPTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COSH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'COVAR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CPU', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CPU_PER_CALL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CPU_PER_SESSION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CRAMERS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CROSSTAB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CUME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CURRENT_SCHEMA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CV', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CYCLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DANGLING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DATA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DATAFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DATAFILES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DATAOBJ', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DATAOBJNO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DBA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DBA_RECYCLEBIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DBTIMEZONE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DBTMEZONE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DBURIGEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DCOM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DDL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEALLOCATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEBUG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DECL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DECODE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DECOMPOSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DECREMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DECRYPT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEDUPLICATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEFAULTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEFERRABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEFERRED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEGREE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DELETEXML', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEMAND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DENSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEPENDENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DEPTH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DESCRIPTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DETAILS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DETERMINES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DICTIONARY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DIMENSION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DIRECT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DIRECTORY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISALLOW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISASSOCIATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISCONNECT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISKGROUP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISKS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISMOUNT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DIST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISTRIBUTE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DISTRIBUTED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DML', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DOCUMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DOWNGRADE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DRIVING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DROP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DSINTERVAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DUMP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DUPLICATES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'DYNAMIC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EDO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ELEMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EMPTY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ENABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ENABLED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ENCODING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ENCRYPT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ENCRYPTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ENFORCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ENFORCED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ENTERPRISE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ENTITYESCAPING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ENTRY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EQUALS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ERROR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ERRORS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ESTIMATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EVALNAME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EVENTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXACT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXCEPT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXCHANGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXCLUDE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXCLUDING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXEC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXISTSNODE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXPAND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXPIRE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXPLAIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXTENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXTENTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXTERNALLY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXTRACT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'EXTRACTVALUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FACT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FAILED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FAILED_LOGIN_ATTEMPTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FAILGROUP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FAST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FEATURE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FEATURE_ID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FEATURE_SET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FEATURE_VALUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FFS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FILESYSTEM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FILTER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FINE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FINISH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FIRST_ROWS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FLAGGER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FLASHBACK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FLOB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FLOOR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FLUSH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FOLLOWING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FOLLOWS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FORCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FOREIGN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FORTRAN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FREELIST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FREELISTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FREEPOOLS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FRESH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'FUNCTIONS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GENERATED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GLOBAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GLOBAL_NAME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GLOBALLY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GRACE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GRANT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GREATEST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GROUPS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GUARANTEE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GUARD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'GUID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HASHKEYS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HEADER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HEAP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HEXTORAW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HIDDEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HIDE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HIERARCHY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HIGH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HINT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HOUR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'HRR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IDENTIFIED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IDENTIFIER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IDENTITY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IDGENERATORS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IDLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IDLE_TIME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IFEMPTY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IGNORE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INCLUDE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INCLUDING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INCREMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'IND_PARTITION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INDENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INDEP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INDEPU', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INDEXED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INDEXES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INDEXTYPE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INDEXTYPES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INDICATOR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INFINITE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INITCAP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INITIAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INITIALIZED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INITIALLY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INITRANS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INLINE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSERTCHILDXML', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSERTCHILDXMLAFTER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSERTCHILDXMLBEFORE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSERTXMLAFTER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSERTXMLBEFORE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSTANCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSTANCES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSTR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSTR2', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSTR4', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSTRB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INSTRC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INTERCEPT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INTERMEDIATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INVALIDATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'INVISIBLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ISOLATION_LEVEL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ITERATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ITERATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'KEEP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'KEY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'KILL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'KS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LABEL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LAG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LAYER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LEAD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LEADING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LEAST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LENGTH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LENGTH2', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LENGTH4', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LENGTHB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LENGTHC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LESS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LEVELS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LIFE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LIKE2', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LIKE4', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LIKEC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LINK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LIST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LISTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LNNVL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOAD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOCALTIMESTAMP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOCATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOCATOR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOCKED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOGFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOGGING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOGICAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOGICAL_READS_PER_CALL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOGICAL_READS_PER_SESSION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOGIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LOWER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LPAD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'LTRIM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAKE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MANAGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MANAGED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MANAGEMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MANUAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAPPING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MASTER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MATERIALIZED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXARCHLOGS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXDATAFILES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXEXTENTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXIMIZE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXINSTANCES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXLOGFILES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXLOGHISTORY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXLOGMEMBERS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXSIZE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXTRANS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MAXVALUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MEAN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MEASURES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MEDIAN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MEDIUM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MEMORY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MIGRATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MINEXTENTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MINIMIZE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MINIMUM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MINING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MINUTE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MINVALUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MIRROR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MODEL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MODIFY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MODULE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MONITOR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MONITORING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MONTHS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MORE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MOUNT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MOVE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MOVEMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MTS_DISPATCHERS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MULTI', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'MW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NAN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NANVL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NATIONAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NATIVE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NAV', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NCHAR_CS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NCHR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NEEDED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NEG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NETWORK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NEVER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NLS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NLSSORT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOAPPEND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOARCHIVELOG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOAUDIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOCACHE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOCOMPRESS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOCYCLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NODELAY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOENTITYESCAPING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOGUARANTEE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOLOGGING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOMAPPING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOMAXVALUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOMINIMIZE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOMINVALUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOMONITORING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NONE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NONSCHEMA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOORDER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOOVERRIDE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOPARALLEL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NORELY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOREPAIR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NORESETLOGS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOREVERSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NORMAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOROWDEPENDENCIES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOSCHEMACHECK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOSORT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOSWITCH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOTHING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NOVALIDATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NTILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NULLIF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NUM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NUMTODSINTERVAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NUMTOYMINTERVAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NVL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'NVL2', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OBJNO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OBJNO_REUSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OBS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OCI', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ODCI', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OFF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OFFLINE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OFFSET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OIDINDEX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ONE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ONLINE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OO40', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OO4O', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OPCODE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OPERATIONS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OPERATOR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OPT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OPTIMAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OPTIMIZER_GOAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ORA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ORDERED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ORDINALITY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ORGANIZATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OUTLINE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OUTLINES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OVER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OVERFLOW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'OWN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PACKAGES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PACKED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PAIRED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PARALLEL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PARAM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PARTITIONS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PASSING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PASSWORD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PASSWORD_GRACE_TIME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PASSWORD_LIFE_TIME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PASSWORD_LOCK_TIME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PASSWORD_REUSE_MAX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PASSWORD_REUSE_TIME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PASSWORD_VERIFY_FUNCTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PATH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PCTFREE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PCTINCREASE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PCTTHRESHOLD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PCTUSED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PCTVERSION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PERCENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PERCENTILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PERFORMANCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PERMANENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PHI', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PHYSICAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PIVOT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PLAN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PLI', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PLS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PLSQL_DEBUG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'POINT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'POOL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'POP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'POS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'POST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'POST_TRANSACTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'POWER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'POWERMULTISET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PQ', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PREBUILT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRECEDING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PREDICTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PREDICTION_COST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PREDICTION_DETAILS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PREDICTION_PROBABILITY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PREDICTION_SET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PREPARE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRESENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRESENTNNV', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRESENTV', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRESERVE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PREVIOUS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRIMARY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRIVATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRIVATE_SGA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRIVILEGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRIVILEGES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PROB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PROBABILITY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PROCEDURAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PROFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PROJECT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PROTECTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PUBLIC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PURGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PUSH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'QB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'QUERY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'QUEUE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'QUIESCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'QUOTA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'R2', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RANK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RATIO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RAWTOHEX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RAWTONHEX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RBA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'READONLY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'READS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REBALANCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REBUILD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RECORDS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RECORDS_PER_BLOCK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RECOVER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RECOVERABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RECOVERY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RECYCLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RECYCLEBIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REDUCED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REDUNDANCY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REFERENCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REFERENCED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REFERENCES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REFRESH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REFTOHEX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REGEXP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REGION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REGISTER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REGR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REJECT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REKEY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RELATIONAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RELIES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RELY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REMAINDER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REMOVE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RENAME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REPAIR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REPLICATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REPORT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REQUIRED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESETLOGS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESIZE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESTORE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESTRICT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESTRICTED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESUMABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RESUME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RETENTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REUSABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REUSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REVOKE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'REWRITE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROLES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROLLING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROUND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROWDEPENDENCIES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROWIDTOCHAR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROWIDTONCHAR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROWLABEL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROWNUM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ROWS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RPAD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RTRIM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RULE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'RULES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SALT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SAMP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SAMPLING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SCAN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SCAN_INSTANCES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SCHEMACHECK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SCN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SCOPE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SD_ALL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SD_INHIBIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SD_SHOW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SDO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SECTION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SECUREFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SEED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SEG_BLOCK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SEG_FILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SELECTIVITY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SEQUENCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SEQUENTIAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SERIALLY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SESSION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SESSION_CACHED_CURSORS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SESSIONS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SESSIONS_PER_USER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SESSIONTIMEZONE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SETTINGS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SGA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SHARED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SHARED_POOL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SHARING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SHOW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SHRINK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SHUTDOWN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SI', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SIDED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SIG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SIGN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SINGLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SINH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SITE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SIZE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SKIP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SKIP_UNUSABLE_INDEXES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SLOPE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SMALL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SMALLFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SNAPSHOT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SOME', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SORT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SOUNDEX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SPACE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SPECIFICATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SPFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SPLIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SQL_TRACE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SQLBUF', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SQLERROR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SQLSTATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SQRT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SQUARES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STANDALONE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STANDBY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STAR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STATEMENT_ID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STATISTIC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STATISTICS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STATS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STOP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STORAGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STORE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STORED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'STRUCTURE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBMULTISET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBPARTITIONS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBQ', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBSTITUTABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBSTR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBSTR2', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBSTR4', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBSTRB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUBSTRC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUCCESSFUL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUPPLEMENTAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SUSPEND', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SWITCH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SWITCHOVER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SXX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SXY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYNONYM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYS_OP_ENFORCE_NOT_NULL$', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYS_OP_NTCIMG$', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYSAUX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYSDBA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYSOPER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYSTEM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYSTIMESTAMP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'SYY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TABLES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TABLESPACE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TABLESPACE_NO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TABNO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TAN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TANH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TEMPFILE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TEMPLATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TEMPORARY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TEST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'THAN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'THREAD', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'THROUGH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TIME_ZONE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TIMEOUT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TIMEZONE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TOPIC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TOPLEVEL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRACE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRACING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRACKING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRAILING', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRANSFORMATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRANSITIONAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRANSLATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TREAT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRIGGERS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRUNC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRUNCATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TRUSTED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TWO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TYPEID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TYPES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'TZ', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UBA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNARCHIVED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNBOUNDED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNDO', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNDROP', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNIFORM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNISTR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNLIMITED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNLOCK', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNNEST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNPACKED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNPIVOT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNPROTECTED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNQUIESCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNRECOVERABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNTIL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNUSABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UNUSED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UPDATABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UPDATED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UPDATEXML', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UPGRADE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UPPER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UPPERCASE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UPSERT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'URL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'USAGE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'USERENV', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'USERS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'UTC', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VALIDATE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VALIDATION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VAR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VERIFY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VERSION', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VERSIONS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VIEW', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VIRTUAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VISIBLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'VSIZE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WAIT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WALLET', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WAY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WELLFORMED', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WHENEVER', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WIDTH', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WITHIN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WITHOUT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'WSR', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XDB', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XID', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XML', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLAGG', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLATTRIBUTES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLCAST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLCDATA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLCOLATTVAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLCOMMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLCONCAT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLELEMENT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLEXISTS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLFOREST', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLGEN', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLINDEX', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLNAMESPACES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLPARSE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLPI', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLQUERY', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLROOT', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLSCHEMA', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLSCHEMAS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLSEQUENCE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLSERIALIZE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLTABLE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLTRANSFORM', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'XMLTYPE', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'YES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'YMINTERVAL', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'ACCEPT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'ALIAS', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'APPINFO', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'ARRAYSIZE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'AUTOCOMMIT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'AUTOPRINT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'AUTOTRACE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'BLOCKTERMINATOR', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'BOLD', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'BREAKS', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'BROWSE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'BTITLE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'BUFFER', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'BULK_EXCEPTIONS', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'CENTER', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'CENTRE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'CMDSEP', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'COL', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'COLSEP', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'COLWIDTH', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'COMPUTES', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'CONCAT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'COPYCOMMIT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'COPYTYPECHECK', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'DEFINE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'DESCRIBE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'DUPLICATES', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'ECHO', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'EDIT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'EDITDATA', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'EDITFILE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'EMBEDDED', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'ERROR_CODE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'ERROR_INDEX', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'EXPORT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'EXPORTDATA', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'FAILURE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'FEEDBACK', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'FOLD_AFTER', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'FOLD_BEFORE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'FORMAT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'GET', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'HEADING', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'HEADSEP', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'HELP', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'HOST', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'INDICES', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'INFO', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'INVISIBLE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'JUSTIFY', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'LINESIZE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'LNO', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'LOBOFFSET', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'LONGCHUNKSIZE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'LOWER', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'MAXIMUM', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'MIXED', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'NATIVE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'NEW_VALUE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'NEWLINE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'NEWPAGE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'NODUPLICATES', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'NOPRINT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'NOPROMPT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'NUMFORMAT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'NUMWIDTH', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'OLD_VALUE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'PAGE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'PAGESIZE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'PAUSE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'PNO', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'PRAGMA_RESTRICT_REFERENCES', 'kind' : 'kyw', 'dup' : 1},
                  \ {'word' : 'PRINT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'PROMPT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'PROPERTIES', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'QUERYDATA', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'QUIT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'RECSEP', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'RECSEPCHAR', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'REFCURSOR', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'RELEASE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'REM', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'REMARK', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'REPORT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'RUN', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SAVE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SCREEN', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SERVEROUTPUT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SHIFTINOUT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SHOW', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SHOWMODE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SPOOL', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SQLCASE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SQLCONTINUE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SQLNUMBER', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SQLPLUS', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SQLPREFIX', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SQLPROMPT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SQLTERMINATOR', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'STD', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SUCCESS', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'SUFFIX', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'TAB', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'TERMOUT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'TIMING', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'TRACEONLY', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'TRIMOUT', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'TRIMSPOOL', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'TRUNCATED', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'TTITLE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'UNDEFINE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'UNDERLINE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'UPPER', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'V7', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'V8', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'VERIFY', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'VISIBLE', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'WARNING', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'WORD_WRAPPED', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'WRAP', 'kind' : 'splus', 'dup' : 1},
                  \ {'word' : 'WRAPPED', 'kind' : 'splus', 'dup' : 1},
                  \ ]

" import libs
runtime! vorax/lib/vim/vorax_utils.vim
runtime! vorax/lib/vim/vorax_dblayer.vim

let s:utils = Vorax_UtilsToolkit()
let s:db = Vorax_DbLayerToolkit()

function! Vorax_Complete(findstart, base)
  " First pass through this function determines how much of the line should
  " be replaced by whatever is chosen from the completion list
  silent! call s:log.trace('start of Vorax_Complete findstart=' . a:findstart . ' base='. a:base)
  if a:findstart
    " Locate the start of the item, including "."
    let line     = getline('.')
    let start    = col('.') - 1
    let complete_from = -1
    let s:prefix   = ""
    let s:params = 0
    silent! call s:log.debug('before UnderCursorStatement')
    let s:crr_statement = s:utils.UnderCursorStatement(0)
    silent! call s:log.debug('UnderCursorStatement='.string(s:crr_statement))
    while start > 0
      if strpart(s:crr_statement[4], 0, s:crr_statement[5] - 1) =~ '[(,]\_s*$'
        " parameters completion
        let s:params = 1
        break
      endif
      if line[start - 1] !~ '\w\|[$#.,(]'
        " If the previous character is not a period or word character
        break
      elseif line[start - 1] =~ '\w\|[$#]'
        " If the previous character is word character continue back
        let start -= 1
      elseif line[start - 1] =~ '\.' 
        if complete_from == -1
          let complete_from = start
        endif
        let start -= 1
      else
        break
      endif
    endwhile
    if complete_from != -1
      let s:prefix = strpart(line, start, complete_from - start)
    endif
    return complete_from == -1 ? start : complete_from
  else
    let result = []
    let parts = split(s:prefix, '\.')
    if len(parts) == 0 && s:params == 0 && a:base != ""
      " completion for a local object
      let result = s:SyntaxItems(a:base)
      call extend(result, s:SchemaObjects("", a:base))
      let result = sort(result, "s:CompareEntries")
    elseif s:params == 1
      "complete procedure parameters
      let result = s:CurrentArguments()
    elseif len(parts) == 1
      " we have a prefix which can be: an alias, an object, a schema... we can't tell
      " for sure therefore we'll try in this order

      " check for an alias
      let result = s:ColumnsFromAlias(s:crr_statement, parts[0], a:base)
      if len(result) == 0
        " no alias could be resolved... go on
        let info = s:db.ResolveDbObject(parts[0])
        if has_key(info, 'schema') 
          if info.type == 2 || info.type == 4
            " complete columns
            let result = s:Columns(info.schema, info.object, a:base, s:prefix)
          elseif info.type == 9 || info.type == 13
            " complete proc/func from the package/type
            let result = s:Submodules(info.schema, info.object, a:base)
          endif
        else
          " it may be a schema name
          let result = s:SchemaObjects(toupper(parts[0]), a:base)
        endif
      endif
    elseif len(parts) == 2
      " we can have here someting like owner.object
      let info = s:db.ResolveDbObject(parts[0] . '.' . parts[1])
      if has_key(info, 'schema') 
        if info.type == 2 || info.type == 4
          " complete columns
          let result = s:Columns(info.schema, info.object, a:base, s:prefix)
        elseif info.type == 9 || info.type == 13
          " complete proc/func from the package/type
          let result = s:Submodules(info.schema, info.object, a:base)
        endif
      endif
    endif
    return result
  endif  
endfunction

" Get columns for the current position which might be comming from
" an alias specified in prefix. Returns a row list of columns. Some
" columns might be in the form of OBJECT.TABLE.*. These has to be further
" fetched using s:ExpandColumns(cols).
function s:ColumnsFromAlias(statement, alias, prefix)
  let stmt = a:statement
  let columns = []
  ruby << EOF
    AliasResolver.columns_for(VIM::evaluate('stmt[4]').upcase, VIM::evaluate('stmt[5]').to_i - 1, VIM::evaluate('a:alias')).each do |col|
      VIM::command('call add(columns, \'' + col + '\')')
    end
EOF
  let columns = s:ExpandColumns(columns, a:prefix)
  if a:prefix != ""
    "filter columns
    let i = 0
    for col in copy(columns)
      if col !~? '^' . a:prefix
        call remove(columns, i)
      else
        let i += 1
      endif
    endfor
  endif
  return sort(columns)
endfunction

" Expand columns provided as TABLE.*. This function is used for expanding
" aliases.
function s:ExpandColumns(cols, prefix)
  let columns = []
  for col in a:cols
    if col =~ '\.\*$'
      " get rid of the last .*
      let col = substitute(col, '\.\*$', "", "")
      " this has to be expanded
      let parts = split(col, '\.')
      if len(parts) == 1
        " expand a local object
        let info = s:db.ResolveDbObject(parts[0])
        if has_key(info, 'schema')
          call extend(columns, s:Columns(info.schema, info.object, "", a:prefix))
        endif
      elseif len(parts) == 2
        " expand an object with a schema specified
        call extend(columns, s:Columns(toupper(parts[0]), toupper(parts[1]), "", a:prefix))
      endif
    else
      let columns += [col]
    endif
  endfor
  return columns
endfunction

" Get all columns which starts with the provided pattern
" from the given owner.table object.
function s:Columns(owner, table, pattern, prefix)
  let col = ""
  if s:utils.IsLower(a:prefix)
    let col = "lower(column_name)"
  else
    let col = "column_name"
  endif
  let owner = a:owner
  if owner == ""
    let owner = "user"
  else
    let owner = "'" . owner . "'"
  endif
  let pattern = substitute(a:pattern, '\(%\|_\)', '`\1', 'g')
  let result = vorax#Exec(
        \ "set linesize 100\n" .
        \ "select " . col . " from all_tab_columns " . 
        \ "where owner=" . owner . 
        \ " and table_name='" . a:table . "'" .
        \ " and column_name like '" . toupper(pattern) . "%' escape '`' " .
        \ " order by column_id;" 
        \ , 0, "")
  return result
endfunction

" Used to compare completion items in order to
" sort them
function! s:CompareEntries(i1, i2)
  return a:i1.word == a:i2.word ? 0 : a:i1.word > a:i2.word ? 1 : -1
endfunction

" Returns a list of keywords starting with the provided parameter
function s:SyntaxItems(start_with)
  let pattern = '^' . a:start_with
  let result = filter(copy(s:keywords), 'v:val.word =~? pattern')
  if &ft == 'plsql'
    " filter sqlplus items
    let result = filter(result, 'v:val.kind != "splus"')
  endif
  if s:utils.IsLower(a:start_with)
    let result = map(result, "{'word':tolower(v:val.word), 'dup':v:val.dup, 'kind':v:val.kind}")
  endif
  return result
endfunction

" Get parameter for the given module/submodule. If module is empty then
" the parameters for a standalone function/procedure is returned.
function s:ParamsFor(owner, module, submodule)
  if s:utils.IsLower(a:submodule)
    let arg = 'lower(argument_name)'
    let type = 'lower(data_type)'
  else
    let arg = 'argument_name'
    let type = 'data_type'
  endif
  let result = vorax#Exec(
        \ "set linesize 100\n" .
        \ "select " . arg . " || ' => ' || '::' || " . type . " || '::' || overload from all_arguments " . 
        \ "where owner='" . a:owner . "'" .
        \ (a:module != "" ? " and package_name ='" . a:module . "'" : "") .
        \ " and object_name ='" . toupper(a:submodule) . "'" .
        \ " and argument_name is not null " .
        \ " and data_level = 0 " .
        \ " order by overload, position;" 
        \ , 0, "")
  return result
endfunction

" Get func/proc parameters corresponding to the current position.
function s:CurrentArguments()
  let stmt = s:crr_statement
  let args = []
  let result = []
  let on_fnc = ""
  ruby << EOF
    f = ArgumentResolver.arguments_for(VIM::evaluate('stmt[4]').upcase, VIM::evaluate('stmt[5]').to_i - 1)
    VIM::command("let on_fnc = '" + f + "'") if f
EOF
  if on_fnc != ""
    let fields = split(on_fnc, '\.')
    if len(fields) == 1
      " a procedure, or a function
      let info = s:db.ResolveDbObject(fields[0])
      if has_key(info, 'schema') && info['schema'] != "" && info['object'] != ""
        let result = s:ParamsFor(info['schema'], '', info['object'])
      endif
    elseif len(fields) == 2
      " could be a package name + procedure or an owner + procedure
      let info = s:db.ResolveDbObject(fields[0])
      if has_key(info, 'schema') && info['schema'] != "" && info['object'] != ""
        if info['type'] == 9
          " a package 
          let result = s:ParamsFor(info['schema'], info['object'], toupper(fields[1]))
        elseif info['type'] == 7 || info['type'] == 8
          " procedure/function with owner
          let result = s:ParamsFor(info['schema'], '', info['object'])
        end
      endif
    elseif len(fields) == 3 
      " owner + package + proc/func
      let info = s:db.ResolveDbObject(fields[0] . '.' . fields[1])
      if has_key(info, 'schema') && info['schema'] != "" && info['object'] != ""
        let result = s:ParamsFor(info['schema'], info['object'], toupper(fields[2]))
      endif
    endif
    for row in result
      let fields = split(row, '::', 1)
      call add(args, {'word' : fields[0], 'kind' : fields[1], 'dup' : 1, 'menu' : fields[2] == "" ? "" : "o" . fields[2] })
    endfor
  endif
  return args
endfunction


" Get user db objects which matches the provided pattern.
function s:SchemaObjects(schema, pattern)
  let obj = ""
  if s:utils.IsLower(a:pattern)
    let obj = "lower(object_name)"
  else
    let obj = "object_name"
  endif
  let pattern = substitute(a:pattern, '\(%\|_\)', '`\1', 'g')
  if a:schema == ""
    let schema = "user, 'PUBLIC'"
  else
    let schema = "'" . a:schema . "'"
  endif
  let result = vorax#Exec(
        \ "set linesize 100\n" .
        \ "select distinct " . obj . " || '::' || " .
        \ "       t1.object_type " .
        \ "  from (select owner, object_name, object_type " .
        \ "          from all_objects o1 " .
        \ "         where object_name like '" . toupper(pattern) . "%' escape '`' " .
        \ "           and owner in (" . schema . ") " .
        \ "           and object_type in ('TABLE', " .
        \ "                               'VIEW', " .
        \ "                               'SYNONYM', " .
        \ "                               'PROCEDURE', " .
        \ "                               'FUNCTION', " .
        \ "                               'PACKAGE', " .
        \ "                               'TYPE')) t1;" 
        \ , 0, "")
  let items = []
  for row in result
    let fields = split(row, '::')
    if type(fields) != 3 || len(fields) != 2
      " unexpected result
      return []
    endif
    let kind = ""
    if fields[1] == 'TABLE'
      let kind = "tbl"
    elseif fields[1] == 'VIEW'
      let kind = "viw"
    elseif fields[1] == 'SYNONYM'
      let kind = "syn"
    elseif fields[1] == 'PROCEDURE'
      let kind = "prc"
    elseif fields[1] == 'FUNCTION'
      let kind = "fnc"
    elseif fields[1] == 'PACKAGE'
      let kind = "pkg"
    elseif fields[1] == 'TYPE'
      let kind = "typ"
    endif
    call add(items, {'word' : fields[0], 'kind' : kind, 'dup' : 1 })
  endfor
  return items
endfunction


" Get all procedures/functions for the provided plsql module
" (package/type). Only the submodules which matches the given
" pattern are returned
function s:Submodules(owner, module, pattern)
  let sm = ""
  if s:utils.IsLower(s:prefix)
    let sm = "lower(procedure_name)"
  else
    let sm = "procedure_name"
  endif
  " check if the subprogram_id column is available. Oracle XE doesn't
  " have it
  let order_by_col = 'procedure_name'
  " commented for performance reasons
  "let column = vorax#Exec("select column_name from all_tab_columns where owner='SYS' and table_name='ALL_PROCEDURES' and column_name='SUBPROGRAM_ID';", 0, "")
  "if len(column) == 1 && column[0] == 'SUBPROGRAM_ID'
  "  let order_by_col = column[0]
  "endif
  let pattern = substitute(a:pattern, '\(%\|_\)', '`\1', 'g')
  let result = vorax#Exec(
        \ "set linesize 100\n" .
        \ "select " . sm . " from all_procedures " .
        \ "where owner='" . a:owner . "'" .
        \ " and object_name='" . a:module . "'" . 
        \ " and procedure_name like '".toupper(pattern)."%' escape '`' " . 
        \ "order by " . order_by_col . ";"
        \ , 0, "")
  return result
endfunction

