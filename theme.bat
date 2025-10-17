@echo off

rem start code \\studentdatasvr.wayneschools.net\studentdata$\valley\14141566\Java\Scripts\theme.bat

rem automatically theme desktop after wipe

rem To set Windows to Dark Mode
    powershell Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force; Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force

rem show file extensions in file explorer
    powershell Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0

    taskkill /f /im explorer.exe
    start explorer

start explorer \\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Work


rem open classroom
    start chrome "https://classroom.google.com/c/Nzc1NDMxNjY3MDM2"

rem install preference tools
    winget install --id=Microsoft.VisualStudioCode  -e --accept-source-agreements
    powershell start '~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code.lnk' \\studentdatasvr.wayneschools.net\studentdata$\valley\$env:UserName\Java\

rem winget install --id=Seelen.SeelenUI  -e
    winget install Microsoft.PowerToys

rem install git
    winget install --id Git.Git -e --source winget

rem install godot
    rem winget wont work, needs admin...
    @REM winget install --id=GodotEngine.GodotEngine -e

    powershell curl -OutFile "~/Downloads/godot_standalone.zip" -Uri "https://github.com/godotengine/godot/releases/download/4.5-stable/Godot_v4.5-stable_win64.exe.zip"
    powershell Expand-Archive -Path "~/Downloads/godot_standalone.zip" -DestinationPath "~/GoDot/"
    del %USERPROFILE%\Downloads\godot_standalone.zip
    echo start %USERPROFILE%\GoDot\Godot_v4.5-stable_win64.exe>>%USERPROFILE%\Desktop\Godot.bat
    start %USERPROFILE%\GoDot\Godot_v4.5-stable_win64.exe

echo theme applied

echo updating script
cd %USERPROFILE%\Downloads\
mkdir theme-script-for-java
cd theme-script-for-java
git pull https://github.com/plexede/theme-script-for-java
cp theme.bat \\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Scripts\theme2.bat