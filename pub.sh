#! /bash
file="/*"
page="/index.html"
BASE_PATH=`pwd`



# echo $BASE_PATH$file
echo $BASE_PATH$page

# scp -r  $BASE_PATH$file root@152.136.122.198:/export/webserver/html
scp -r  $BASE_PATH$file root@49.233.191.228:/usr/share/nginx/html/resume
# upload index.html
# scp $BASE_PATH$page   root@49.233.191.228:/usr/share/nginx/html/mzfont


echo "\033[32m---index页面--上传成功......\033[0m"

# rm -rf dist
