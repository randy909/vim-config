if !exists( "g:__XPTEMPLATE_VIM__" )
  " load only if xptemplate plugin is loaded
  finish
endif

XPTemplate priority=sub

let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common

" select star
XPT ss hint=select\ *
select * from `table_name^;
..XPT

" select alias
XPT sa hint=select\ alias.*
XSET ComeFirst=table_name alias
select `alias^.`cursor^ from `table_name^ `alias^;
..XPT

XPT cor
create or replace `cursor^
..XPT

XPT package
XSET package_name=fnamemodify( bufname( '%' ), ':t:r' )
create or replace package `package_name^ as
  `cursor^
end;
/
create or replace package body `package_name^ as
  
end;
/
..XPT
u

XPT function
XSET name=fnamemodify( bufname( '%' ), ':t:r' )
function `name^ return `type^ as
begin
  `cursor^
end;
..XPT

XPT procedure
XSET name=fnamemodify( bufname( '%' ), ':t:r' )
procedure `name^ as
begin
  `cursor^
end;
..XPT

XPT type
XSET type_name=fnamemodify( bufname( '%' ), ':t:r' )
create or replace type `type_name^ as
  `cursor^
end;
/
create or replace type body `type_name^ as
  
end;
/
..XPT

XPT if
if `condition^ then
  `cursor^
end if;
..XPT

XPT loop
loop
  exit when `condition^;
  `cursor^
end loop;
..XPT

XPT for
for `var^ in `range^ loop
  `cursor^
end loop;
..XPT

XPT declare
declare
  `declare_stuff^
begin
  `body^
end;
..XPT

XPT begin
begin
  `cursor^
end;
..XPT

XPT trace
set autotrace on
..XPT

XPT traceonly
set autotrace traceonly
..XPT
