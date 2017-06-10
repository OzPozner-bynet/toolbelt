:rails
@netstat -na | findstr "0:3030"
if %ERRORLEVEL% == 1 cmd /c rs3030.bat
:redis
@netstat -na | findstr "0:6379"
if %ERRORLEVEL% == 1 cmd /c .\redis\redis-server
:sidekiq
cmd /k "bundle exec sidekiq"

