@echo off
@SET var_path=%cd%
@SET bynet_tb_path=%cd%
SetX bynet_tb_path %cd%
ECHO installing in path: %var_path%
@mkdir c:\temp >>nul
@cd c:\temp
IF NOT %ERRORLEVEL% EQU 0 goto temp_path_error

if "%1"=="pem" goto install_pem
rem install rails/ruby
ruby -v
IF NOT %ERRORLEVEL% EQU 0 goto install_ruby
@echo found ruby installing Oz Ping
goto install_ozping
:install_ruby
@Echo ruby not found installing ruby
set old_path=%path%
path=%path%;%var_path%;%var_path%\gnu\bin;%var_path%\net
which rails
IF NOT %ERRORLEVEL% EQU 0 goto install_rails
@echo found rails updating ca certificate
goto install_ozping
:install_rails
wget https://s3.amazonaws.com/railsinstaller/Windows/railsinstaller-3.4.0.exe --no-check-certificate
railsinstaller-3.4.0.exe
rem #was# cmd /k railsinstaller-3.0.0.exe
del c:\temp\railsinstaller-3.4.0.exe
:install_pem
@Echo installing CA .pem
wget https://raw.githubusercontent.com/smalruby/smalruby-installer-for-windows/master/Ruby216_32/lib/ruby/2.1.0/rubygems/ssl_certs/AddTrustExternalCARoot-2048.pem --no-check-certificate
move c:\temp\AddTrustExternalCARoot-2048.pem c:\RailsInstaller\Ruby2.0.0\lib\ruby\2.0.0\rubygems\ssl_certs\AddTrustExternalCARoot-2048.pem
set path=%old_path%
:install_OzPing
rem setting requirements for op.rb
@echo Setting requirements for op.rb
mkdir c:\temp\logs >>nul
mkdir c:\temp\log >>nul
cd %bynet_tb_path%
bundle install
gem install net-ping win32-security logger snmp rego net-telnet parseconfig hash_parser
gem install csv -v '3.1.3'


GOTO end
:temp_path_error
Echo Can't create path c:\temp  rerun after cmd "mkdir c:\temp" succsed! aborting install
:end
@echo Done installation %TIME%