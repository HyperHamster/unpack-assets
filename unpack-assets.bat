@echo off

if "%*"=="/?" goto :help
if "%*"=="" set mode=:unpack_starbound&& goto :choice
if "%*"=="/a" set mode=:unpack_workshop_all&& goto :choice
if "%*"=="/A" set mode=:unpack_workshop_all&& goto :choice
set mode=:unpack_workshop

:choice

echo 1: Select default 64-bit system Steam library location (C:\Program Files (x86)\Steam).
echo 2: Select default 32-bit system Steam library location (C:\Program Files\Steam).
echo 3: Enter your own custom Steam library location.
echo Q: Quit.

choice /c:Q123K /n

if "%errorlevel%"=="1" goto :end
if "%errorlevel%"=="2" set steam_library=C:\Program Files ^(x86^)\Steam&& goto :begin
if "%errorlevel%"=="3" set steam_library=C:\Program Files\Steam&& goto :begin
if "%errorlevel%"=="4" goto :prompt
if "%errorlevel%"=="5" set steam_library=D:\Windows\Steam Games&& goto :begin

:prompt

set /p user_input=Specify your Steam Library location: 
set steam_library=%user_input%

:begin

set starbound=%steam_library%\steamapps\common\Starbound
set starbound_workshop=%steam_library%\steamapps\workshop\content\211820
set unpack=%starbound%\win32\asset_unpacker.exe
set starbound_assets=%starbound%\assets\packed.pak

goto %mode%

:unpack_starbound

if exist "%starbound_assets%" (
    if exist "%starbound%\_UnpackedAssets" (
        echo Removing Starbound^'s old unpacked assets...
        rd /s /q "%starbound%\_UnpackedAssets"
        echo Done.
    )
    
    echo Unpacking Starbound^'s assets...
    "%unpack%" "%starbound_assets%" "%starbound%\_UnpackedAssets" >nul
    echo Done.
    goto :end
)

echo Starbound^'s assets not found.
pause
goto :end

:unpack_workshop

if exist "%starbound_workshop%\%1" (
    if exist "%starbound%\mods\%1" (
        echo Removing %1^'s old unpacked assets...
        rd /s /q "%starbound%\mods\%1"
        echo Done.
    )
    
    echo Unpacking %1^'s assets...
    "%unpack%" "%starbound_workshop%\%1\contents.pak" "%starbound%\mods\%1" >nul
    echo Done.
    goto :end
)

echo %1^'s assets not found.
pause
goto :end

:unpack_workshop_all

set num_loops=0
for /f %%g in ('dir /b /a:d "%starbound_workshop%"') do (
    set /a "num_loops+=1"
    
    if exist "%starbound%\mods\%%g" (
        echo Removing %%g^'s old unpacked assets...
        rd /s /q "%starbound%\mods\%%g"
        echo Done.
    )
    
    echo Unpacking %%g^'s assets...
    "%unpack%" "%starbound_workshop%\%%g\contents.pak" "%starbound%\mods\%%g" >nul
    echo Done.
)

if "%num_loops%"=="0" (
    echo No mods found.
    pause
    goto :end
)

echo Finished unpacking %num_loops% mod(s).
goto :end

:help

echo Unpacks Starbound assets.
echo.
echo unpack-assets.bat [/a] [workshop_id]
echo.
echo   /a    Unpack *ALL* Starbound Steam Workshop assets.
echo.
echo Given no arguments, unpacks Starbound's assets.
echo Given one argument that is an installed Starbound Steam Workshop ID, unpacks its assets.
echo Given the /a switch, unpacks *ALL* Starbound Steam Workshop assets.

:end
