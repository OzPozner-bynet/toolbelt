@echo off
if exist c:\bynet\tools\ (
  @cd c:\bynet\tools\%1
) else (
  @cd   c:\bynet\toolbelt\%1
)


