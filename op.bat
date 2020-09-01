@echo off
goto version2
:version1
	@cd c:\bynet\tools\
	AT > NUL
	IF %ERRORLEVEL% EQU 0 (
		ECHO you are Administrator
		ruby c:\bynet\tools\ruby\op.rb %1 %2 %3 %4 %5 %6 %7 %8 %9 
	) ELSE (
		ECHO you are NOT Administrator. Elevating...
		PING 127.0.0.1 > NUL 2>&1
		Nircmd\NIRCMD.exe elevate cmd /k ruby  c:\bynet\tools\ruby\op.rb %1 %2 %3 %4 %5 %6 %7 %8 %9 
		EXIT /B 1
)
goto end

:version2
if "%bynet_tb_path%"=="" (ra ruby c:\bynet\tools\ruby\op.rb %*) else (ra ruby %bynet_tb_path%\ruby\op.rb %*)
goto end
:end


