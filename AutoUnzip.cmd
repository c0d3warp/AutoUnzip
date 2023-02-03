@echo off
setlocal enabledelayedexpansion

set msg_displayed=0

color 03
type ascii-art.txt
color 03

:start
if not %msg_displayed% == 1 (
echo Looking for new archives...
  set msg_displayed=1
)
timeout /t 5 > nul

for %%e in (zip 7z) do (
  for /f "tokens=*" %%a in ('dir /b /od *.%%e 2^>nul') do (
    set file=%%a
    if %%e == zip (
      if not exist "!file:~0,-4!" md "!file:~0,-4!"
      powershell -command "Expand-Archive -Path '%cd%\!file!' -DestinationPath '!file:~0,-4!'"
    ) else (
      if not exist "!file:~0,-3!" md "!file:~0,-3!"
      "C:\Program Files\7-Zip\7z.exe" e "!file!" -o"!file:~0,-3!"
    )
    del "!file!"
echo:
echo:
    echo Decompressing Complete^^!
  )
)

goto start
