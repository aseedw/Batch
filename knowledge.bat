@echo off

::==============================================
:: prints an empty line
echo.

::==============================================
:: change text color

setlocal EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

rem Prepare a file "X" with only one dot
<nul > X set /p ".=."

call :ColorText 0a "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
call :ColorText 0b "b"
call :ColorText 0c "^!<>&| %%%%"*?"

:ColorText
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
exit /b
