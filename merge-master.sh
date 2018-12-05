#!/bin/bash

exec > >(awk '{print strftime("%Y-%m-%d %H:%M:%S [1] "),$0; fflush();}')
exec 2> >(awk '{print strftime("%Y-%m-%d %H:%M:%S [2] "),$0; fflush();}' >&2)

starttime=$(date +%s)

echo "Merging in upstream master..."

[ -z "$(git remote -v |grep upstream)" ] && git remote add upstream https://github.com/der-stefan/OpenTopoMap
git fetch upstream
git checkout master
git merge upstream/master

endtime=$(date +%s)
echo "Done in $[${endtime}-${starttime}] seconds! All your Maps Belong to Us!"