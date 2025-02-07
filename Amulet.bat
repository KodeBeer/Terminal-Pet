@echo off
setlocal enabledelayedexpansion

:: Define the counter file
set COUNTER_FILE=C:\Users\Ko\Documents\shellAmulet\counter.txt

:: Check if the counter file exists
if not exist "%COUNTER_FILE%" (
    echo 0 > "%COUNTER_FILE%"  :: If the file doesn't exist, initialize counter to 0
)

:: Read the current counter value from the file
set /p counter=<%COUNTER_FILE%

:: Increment the counter
set /a counter+=1

:: Save the updated counter value back to the file
echo %counter% > "%COUNTER_FILE%"

echo O__________________
echo  ^|___________     ^|
echo  ^|     @@   ^|  o  ^|
echo  ^|  ^\  ##^>  ^|^\  / ^|
echo  ^|   ###    ^| ^\o  ^|
echo  ^|  ^/   \   ^| /\  ^|
echo  ^|__________^|/ o\ ^|
echo  ^|________________^|


:: Display the current counter value
echo You are level %counter%

pause


