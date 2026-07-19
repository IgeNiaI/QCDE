@echo off
setlocal enabledelayedexpansion

set "pattern=%~1"

if not defined pattern (
    echo Usage: rename.bat ####*#
    exit /b 1
)

if "%pattern:~6,1%" neq "" (
    echo Parameter must be 6 characters long.
    exit /b 1
)

if "%pattern:~5,1%"=="" (
    echo Parameter must be 6 characters long.
    exit /b 1
)

if not "%pattern:~4,1%"=="*" (
    echo Fifth character must be *.
    exit /b 1
)

set "alphabet=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
set "count=0"
set "before=!pattern:~0,4!"
set "after=!pattern:~5,1!"

for %%f in (*.png) do (
    if !count! lss 26 (
        call set "char=%%alphabet:~!count!,1%%"
        ren "%%f" "!before!!char!!after!.png"
        echo %%f --^> !before!!char!!after!.png
        set /a count+=1
    )
)
