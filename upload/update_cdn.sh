#!/bin/sh
dir=`pwd`
zipfile=client_add.zip
rm -rf $zipfile
rz -y

if [ ! -f "$dir/$zipfile" ]; then
	echo "$zipfile is not find!"
	exit 1
fi

ver=$1
ver1="v$ver"
while true
do
	ver=$[$ver+1]
	ver2="v$ver"
	path=$dir/$ver2
	if [ ! -d "$path" ]; then
		break
	fi
done

cp -r $ver1 $ver2
unzip -o $zipfile -d $ver2
rm -rf client_add.zip
echo -e "\e[1;31m new version:$ver2 \e[0m"
