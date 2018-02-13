svn status $1 | grep "D" | awk '{print $2}' | while read line;do svn revert ${line};done;
