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

::==============================================
:: wait user to input

SET /P variable=message

::==============================================
:: get os name

:: method 1
systeminfo

:: method 2
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "6.3" echo Windows 8.1
if "%version%" == "6.2" echo Windows 8.
if "%version%" == "6.1" echo Windows 7.
if "%version%" == "6.0" echo Windows Vista.

::Operating system	        Version number
::Windows 10                10.0*
::Windows Server 2016	      10.0*
::Windows 8.1	              6.3*
::Windows Server 2012 R2	  6.3*
::Windows 8	                6.2
::Windows Server 2012	      6.2
::Windows 7	                6.1
::Windows Server 2008 R2	  6.1
::Windows Server 2008	      6.0
::Windows Vista	            6.0
::Windows Server 2003 R2	  5.2
::Windows Server 2003	      5.2
::Windows XP 64-Bit Edition	5.2
::Windows XP	              5.1
::Windows 2000	            5.0
::https://msdn.microsoft.com/en-us/library/windows/desktop/ms724832(v=vs.85).aspx
