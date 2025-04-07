#!/bin/bash

# 顯示執行的命令
set -x

# 錯誤時終止腳本
set -e

# 確保在 master 分支
echo "切換到 master 分支..."
git checkout master

# 重新編譯
echo "重新編譯 Hugo 網站..."
hugo

# 備份 public 目錄
echo "備份 public 目錄..."
rm -rf ../_site-temp
cp -r public ../_site-temp

# 切換到 gh-pages 分支
echo "切換到 gh-pages 分支..."
git checkout gh-pages

# 清除舊內容
echo "清除舊內容..."
git rm -rf .

# 複製新的內容
echo "複製新內容..."
cp -r ../_site-temp/* .

# 添加 .nojekyll 文件（防止 GitHub Pages 使用 Jekyll 處理）
touch .nojekyll

# Commit 和 Push
echo "提交變更..."
git add .
git commit -m "更新網站內容 $(date '+%Y-%m-%d %H:%M:%S')"
git push origin gh-pages

# 切回 master 分支
echo "切回 master 分支..."
git checkout master

# 清理暫存目錄
echo "清理暫存目錄..."
rm -rf ../_site-temp

echo "部署完成！" 
