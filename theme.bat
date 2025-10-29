@echo off

rem automatically theme desktop after wipe

rem To set Windows to Dark Mode
    powershell Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force; Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force

rem show file extensions in file explorer
    powershell Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0

    taskkill /f /im explorer.exe
    start explorer

rem ensure remote folders exist
if not exist "\\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Scripts\" (
    mkdir "\\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Scripts"
)
if not exist "\\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Work\" (
    mkdir "\\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Work"
    echo "This is your Java Work folder. Place your Java projects here." > "\\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Work\readme.txt"
)

start explorer \\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Work

rem open classroom
    start chrome "https://classroom.google.com/c/Nzc1NDMxNjY3MDM2"

rem install preference tools
    winget install --id=Microsoft.VisualStudioCode  -e --accept-source-agreements
    powershell start '~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code.lnk' \\studentdatasvr.wayneschools.net\studentdata$\valley\$env:UserName\Java\
    cp '~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code.lnk' '%USERPROFILE%\Desktop\Visual Studio Code.lnk'

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

echo Theme applied.


if "%USERNAME%"=="14141566" (
    cd /d "%USERPROFILE%\Downloads"
    if exist "%USERPROFILE%\Downloads\Honors-Computer-Programming" (
        echo Removing existing local clone...
        rmdir /s /q "%USERPROFILE%\Downloads\Honors-Computer-Programming"
    )

    echo Cloning Honors-Computer-Programming repository...
    git clone https://github.com/plexede/Honors-Computer-Programming "%USERPROFILE%\Downloads\Honors-Computer-Programming"

    if not exist "%USERPROFILE%\Downloads\Honors-Computer-Programming" (
        echo Clone failed — aborting copy.
    ) else (
        echo Copying repository contents to network Work folder...
        REM Ensure destination exists (earlier in script already creates it, but be safe)
        if not exist "\\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Work" (
            mkdir "\\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Work"
        )
        REM Use robocopy to copy everything, retry few times on transient errors
        robocopy "%USERPROFILE%\Downloads\Honors-Computer-Programming" "\\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Work" /MIR /COPYALL /R:3 /W:5
        if %ERRORLEVEL% LSS 8 (
            echo Copy completed successfully (robocopy exit code %ERRORLEVEL%).
        ) else (
            echo Copy finished with errors (robocopy exit code %ERRORLEVEL%).
        )
        REM Optional: remove local clone to save space
        echo Cleaning up local clone...
        rmdir /s /q "%USERPROFILE%\Downloads\Honors-Computer-Programming"
    )
)

echo Updating script...
cd %USERPROFILE%\Downloads\
git clone https://github.com/plexede/theme-script-for-java
cd theme-script-for-java
copy theme.bat \\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Scripts\theme.bat
echo Update complete.

@REM rem temporary map + change to UNC, do work, then restore
@REM pushd \\studentdatasvr.wayneschools.net\studentdata$\valley\%USERNAME%\Java\Work
@REM mkdir Scripts
@REM copy theme.bat ".\Scripts\theme.bat"
@REM popd