@echo off
:check_admin
echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed. setting Gateways
        goto running_as_admin
    ) else (
        rem echo Failure: Current permissions inadequate.
        goto not_admin   
        rem if you hvae bynet tools installed you can run: ra set_gw.bat
    )
:goto exit
:running_as_admin
set n0=10.111.99.0
set n1=192.168.0.0
Echo looking for Gateway to network "%n0%" and adding route to networks:  
echo "%n1%"/24

route print | findstr "%n0%" >c:\temp\route0.txt
route print | findstr "%n1%" >c:\temp\route1.txt

for /f "tokens=1,2,3,4 delims= " %%a in (c:\temp\route0.txt) do (
 @echo found gateway %%c checking routes
  for %%R in (c:\temp\route1.txt) do (
    if not %%~zR lss 1 (
      echo route to  "%n1%" is missing : adding  
      route add %n1% mask 255.255.255.0 %%c metric 5
	  route add 172.17.17.0 mask 255.255.255.0 %%c metric 5
	)
  )	
)
:clean_up
del c:\temp\route0.txt
del c:\temp\route1.txt
goto exit
:not_admin
@echo you must run this command as admin
@echo you are not admin please elevate or run RA set_GW
:exit
