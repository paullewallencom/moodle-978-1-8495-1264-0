@echo off
@set mysqldir="C:\Program Files\MySQL\MySQL Server 5.0"
@set dbname=nlcdevdb
@set now=%date:~0,2%-%date:~3,2%-%date:~6,4%
@set bckupdir=F:\backup
@set archive=%bckupdir%\dump_%now%
@set logfile=%archive%.log
@set backupfile=%archive%.sql
@set config=F:\Projects\moodle_book\ch10\scripts\my.ini

@%mysqldir%\bin\mysqldump.exe --defaults-file=%config% -r %backupfile% %dbname% 2> %logfile%

if %errorlevel% neq 0 goto dberr
goto end

:dberr
echo Unable to backup database %dbanme%. Check %logfile% .


:end
