
## How to deploy 
# 回 master
git checkout master

# 重新編譯（根據 baseURL）
hugo

# 備份 public
cp -r public ../_site-temp

# 切到 gh-pages
git checkout gh-pages

# 清除舊內容
git rm -rf .

# 貼回最新的 public
cp -r ../_site-temp/* .

# Commit & push
git add .
git commit -m "fix baseURL and deploy"
git push origin gh-pages

# 刪除暫存資料夾
rm -rf ../_site-temp



# 本地開發無法啟動 解決方法 ->重新安裝papermod主題
rm -rf themes/hugo-PaperMod && git clone https://github.com/adityatelange/hugo-PaperMod.git themes/hugo-PaperMod

# 重新啟動hugo server
hugo server -D


