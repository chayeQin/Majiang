@echo off

title android

set game=majiang
set lang=cn

set DIR=%~dp0
set src=%DIR%%game%\cocosstudio\
set target=%DIR%../dev\gameclient\res\%game%\share\

set lang_src=%DIR%%game%\cocosstudio\text\
set lang_target=%DIR%../dev\gameclient\res\%game%\%lang%\text\

set csb_src=%DIR%%game%\csb\
set csb_target=%DIR%../dev\gameclient\res\%game%\share\csb\

echo %src%
xcopy /sdy "%src%*.*" "%target%*" /exclude:%DIR%EXCLUDE.txt
xcopy /sdy "%csb_src%*.*" "%csb_target%"
xcopy /sdy "%lang_src%*.*" "%lang_target%"

pause