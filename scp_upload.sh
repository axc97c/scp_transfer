#!/bin/bash

IFS=$'\n'
source="/home11/axc97c2/Completed"
targettemp="/disk2/tmp/torrent"
target="/disk2/downloads/torrent"
USER=$1
HOST=$2
PORT=$3

for category in movies movies-4k tv
do

        echo $category

        for file in `find $source/$category -maxdepth 1 -mindepth 1 ! -name '*parts~'`
        do
                echo $file
                scp -r -P $PORT "$file" $USER@$HOST:$targettemp/$category/ && rm -rf "$file"
        done

        ssh $USER@$HOST -p $PORT mv $targettemp/$category/* $target/$category/
        ssh $USER@$HOST -p $PORT chmod 777 -R $target/$category

done
