@echo off
set DIR=%~dp0
set key=Ksfxxe_Adddjjds
set sign=XXJYX
set game_name=
set client=E:\jyx_prj_001\all\dev\gameclient\
set src=%client%src\
set out=%client%res\
set run=%DIR%..\compile_scripts.bat

echo ********* Ñ¹Ëõ½Å±¾ ***********
%run% -m files -x config -i %src% -o %out% -ek %key% -es %sign% -e xxtea_chunk -ex lua
del /s %out%*Test*.*