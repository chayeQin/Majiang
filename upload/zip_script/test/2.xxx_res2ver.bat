@echo off
echo �������а汾�ļ���ֻ�����·�������Ҫִ��������
echo 

set /p a=ȷ���Ļ���������o���س���
if /i "%a%"=="o" goto o

goto n

:o
set /p a=ȷ���Ļ�����������k���س���
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