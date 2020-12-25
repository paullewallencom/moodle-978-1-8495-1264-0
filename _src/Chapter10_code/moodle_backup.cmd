@echo off
@set backupcmd="C:\Program Files\MySQL\MySQL Server 5.1\bin\mysqldump.exe"
@set dbname=moodle
@set now=%date:~4,2%-%date:~7,2%-%date:~10,4%
@set bckupdir=Z:\backup
@set config=%~dp0my.ini
@set archive=%bckupdir%\dump_%now%
@set logfile=%archive%.log
@set backupfile=%archive%.sql
@set successmsg=Backup finished OK!
@set errormsg=Unable to backup database ^
%dbanme%. Check %logfile%.

@%backupcmd% --defaults-extra-file=%config% ^
-r %backupfile% %dbname% 2> %logfile%

@if %errorlevel% neq 0 goto dberr
@echo %successmsg%
@goto end

:dberr
@echo %errormsg% 1>&2
@eventcreate /l application /t error ^
/so Moodle /id 1 /d "%errormsg%"

:end
