#!/bin/sh
if [ ! -n "$1" ]; then
echo "如:上传更新"
exit 0
fi

svn status $1 | grep "?" | awk '{print $2}' | while read line;do svn add ${line};done;
svn status $1 | grep "!" | awk '{print $2}' | while read line;do svn del ${line};done;
svn ci -m "update ios" $1*
