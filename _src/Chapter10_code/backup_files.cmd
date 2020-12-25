@echo on
@set now=%date:~4,2%-%date:~7,2%-%date:~10,4%
@set source=Z:\website
@set destinationroot=Z:\backup
@set destination="%destinationroot%\%now%"
@set logfile="%destinationroot%\backup_%now%.log"
@set successmsg=Backup created in %destination%
@set failmsg=^
Unable to create backup! Check log file %logfile%
@set direrrmsg=^
Invalid output directory! Check %destinationroot%
@set scriptname=Moodle
@if not exist "%destinationroot%" goto desterr

@xcopy %source% %destination% ^
       /e /v /k /x /i /y ^
       1>%logfile% 2>&1

@if %errorlevel% neq 0 goto copyerr
@echo %successmsg%
@eventcreate /l application /t information ^
 /so "%scriptname%" /id 1 /d "%successmsg%" > NUL
@goto end

:desterr
@echo %direrrmsg% 1>&2
@eventcreate /l application /t error ^
 /so "%scriptname%" /id 2 /d "%direrrmsg%" > NUL
@goto end

:copyerr
@echo %failmsg% 1>&2
@eventcreate /l application /t error ^
 /so "%scriptname%" /id 3 /d "%failmsg%" > NUL

:end
