#!/bin/bash

echo "1正在添加所有更改到 Git..."
git add .
echo "1=======添加完成"

echo "2正在提交更改..."
git commit -m "gs"
echo "2=======已提交到暂存区..."

echo "3正在推送到远程仓库..."
git push
echo "3=======已推送到远程"

echo "4正在清除 Hexo 缓存..."
hexo clear
echo "4=======已完成缓存清理"

echo "5正在生成静态文件..."
hexo g
echo "5=======静态文件生成正常"

echo "6正在部署到服务器..."
hexo d
echo "部署完成！😁"
