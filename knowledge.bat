@echo off

::==============================================
:: multiple commands in one line

::example
echo command1 & echo command2 & echo command3

::==============================================
:: network get interface name

wmic nic where "netconnectionid like '%'" get netconnectionid

:: output ::
:: NetConnectionID
:: Local Area Connection
:: Wireless Network Connection
:: Bluetooth Network Connection
:: VirtualBox Host-Only Network

::==============================================
:: network set ip

:: static ip ( static ip mask dns )
netsh interface ip set address "Local Area Connection" static 192.168.0.10 255.255.255.0 192.168.0.1 1

:: dhcp
netsh interface ip set address "Local Area Connection" dhcp

::==============================================
:: network check interface is connected or not

netsh interface show interface name="Local Area Connection"

:: output
::Local Area Connection
:: Type:                 Dedicated
:: Administrative state: Enabled
:: Connect state:        Disconnected

:: example
:loop
timeout 2
echo still waiting...
netsh interface show interface name="Local Area Connection" | find "Connect state" |find "Connected" >nul || goto :loop
echo Interface is now connected.

::==============================================
:: create empty file

type NUL > file.txt

::==============================================
:: timeout

:: timeout 10 sec
timeout /t 10

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

::==============================================
:: if

:: if elseif example
IF %F%==1 IF %C%==1 (
    ::copying the file c to d
    copy "%sourceFile%" "%destinationFile%"
    )

IF %F%==1 IF %C%==0 (
    ::moving the file c to d
    move "%sourceFile%" "%destinationFile%"
    )

IF %F%==0 IF %C%==1 (
    ::copying a directory c from d, /s:  boş olanlar hariç, /e:boş olanlar dahil
    xcopy "%sourceCopyDirectory%" "%destinationCopyDirectory%" /s/e
    )

IF %F%==0 IF %C%==0 (
    ::moving a directory
    xcopy /E "%sourceMoveDirectory%" "%destinationMoveDirectory%"
    rd /s /q "%sourceMoveDirectory%"
    )

::if else example
if %c%==15 (echo "The value of variable c is 15") else (echo "Unknown value") 

::==============================================
:: set console langauge

:: To English
chcp 437 

::==============================================
:: print .txt

type filename

::==============================================
:: replace string

:: replace space as nothing
SET String=!String: =!

:: 1. Replace string "work" with "play"
set string=This is my string to work with.
set string=%string:work=play%
echo %string%

::Output = This is my string to play with.

:: 2. Remove the string "to work with."
set string=This is my string to work with.
set string=%string:to work with.=%
echo %string%

::Output = This is my string

:: 3. Replace all spaces with an underscore
set string=This is my string to work with.
set string=%string: =_%
echo %string%

::Output = This_is_my_string_to_work_with.

:: 4. Remove all spaces
set string=This is my string to work with.
set string=%string: =_%
echo %string%

::Output = Thisismystringtoworkwith.

:: 5. Replace a string using other existing variables

::To replace one substring with another using details in a variable then you need to turn on delayed expansion and use the variation below.

@echo off
setlocal enabledelayedexpansion
set string=This is my string to work with.
set find=my string
set replace=your replacement
call set string=%%string:!find!=!replace!%%
echo %string%

::Output = This is your replacement to work with.

:: 6. Find rest of string after one looked for

::This looks for the string "my string " and the * before the string to look for means to match any other characters. This whole string is removed leaving the rest of the line.

@echo off
setlocal enabledelayedexpansion
set string=This is my string to work with.
set "find=*my string "
call set string=%%string:!find!=%%
echo %string%

::Output = to work with.

:: 7. Find the line up to the string searched for

::This looks for the string "*my string " and gets the rest of the line into the variable %delete%. It then substitutes the string from %delete% with nothing.

@echo off
setlocal enabledelayedexpansion
set string=This is my string to work with.
set "find=*my string "
call set delete=%%string:!find!=%%
call set string=%%string:!delete!=%%
echo %string%

::Output = This is my string

::This only works of course if the strings are not going to be found elsewhere in the line, e.g. with the string below removes both "to work with" strings 

set string=This to work with is my string to work with 

::Output = This is my string
