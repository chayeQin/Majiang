@echo off
set DIR=%~dp0
set key=fdIIkd-_-XndI
set sign=xxx!zip

set lang=th
set client=%DIR%..\..\..\code\gameclient\sds\
set src=%client%hd_card_%lang%\
set out=%DIR%..\..\sds\%lang%\client\hd_card
set cfg=%out%hd_card
set zipApp=%DIR%..\
set ogg="%zipApp%win32\ogg"
set png="%zipApp%win32\pngquanti.exe"
set webp="%zipApp%win32\webp\cwebp.exe"
set run=%zipApp%pack_files.bat

echo ********* º”√‹◊ ‘¥ ***********
call %run% -i %src% -o %out% -ek %key% -es %sign% -p %cfg% -t png,jpg -xa jpg,mp3,mp4,pl -xi jpg,ogg,ttf,mp4,pl -xp webp,oog,ttf,mp4,pl -png %png% -ogg %ogg% -webp %webp%
pause