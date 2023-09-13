@echo off
echo %date% %time% running ping 8.8.8.8 into   %USERPROFILE%\ping8888.txt
ping -n 2 8.8.8.8
:loop
@echo %date% %time% >> %USERPROFILE%\ping8888.txt
@which fping | find /i ".EXE"
if not errorlevel 1 (
  echo %date% %time% running ping 8.8.8.8 into  %USERPROFILE%\ping8888.txt
  powershell "ping -n 300 8.8.8.8 | tee -Append  %USERPROFILE%\ping8888.txt"
) else  (
  echo %date% %time% running fping 8.8.8.8 into  %USERPROFILE%\ping8888.txt
  fping 8.8.8.8 -n 300 -L  %USERPROFILE%\fping8888.txt
)
goto loop