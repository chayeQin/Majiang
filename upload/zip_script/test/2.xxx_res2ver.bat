@echo off
echo 生成现有版本文件，只有重新发包才需要执行批处理
echo 

set /p a=确定的话，请输入o按回车：
if /i "%a%"=="o" goto o

goto n

:o
set /p a=确定的话，请再输入k按回车：
if /i "%a%"=="k" goto k

:k
set lang=cn
set DIR=%~dp0
set client=%DIR%..\..\..\code\gameclient\
set src=%client%%lang%\
set out=%DIR%..\..\%lang%\client\
set cfg=upload_list.ver
set run=%DIR%..\pack_files_list.bat

call %run% -i %src% -o %out% -c %cfg% -t jpg,webp,mp3,ogg -f lua
pause

:n
exit