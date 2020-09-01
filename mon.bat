@echo off 
set vpath=%cd%
@echo running Mon DriveTest in single run mode / edit %vpath%\mon.bat to include goto start to run continusly 
:start
if "%bynet_tb_path%"=="" (ruby -W0 c:\bynet\tools\DriveTest\mon8.rb) else (ruby -W0 %bynet_tb_path%\DriveTest\mon8.rb) 
REM goto start
:end



