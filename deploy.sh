#!/bin/bash

echo "正在添加所有更改到 Git..."
git add .

echo "正在提交更改..."
git commit -m "gs"

echo "正在推送到远程仓库..."
git push

echo "正在清除 Hexo 缓存..."
hexo clear

echo "正在生成静态文件..."
hexo g

echo "正在部署到服务器..."
hexo d

echo "部署完成！"
