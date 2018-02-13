@echo off

set DIR=%~dp0
echo %DIR%
set DIR=%~dp0
set path_file=%DIR%../conf/apk_src_trunk.txt
for /f "eol=#" %%c in (%path_file%) do (
    set APP_ROOT=%%c
)
set APP_ROOT=%APP_ROOT%yhbz\client\
title src:%APP_ROOT%

set out=%DIR%assets\res\

echo %APP_ROOT%
echo %out%

xcopy /syd "%APP_ROOT%*.*" "%out%" /exclude:%DIR%EXCLUDE.txt