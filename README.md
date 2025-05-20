
# 本地開發無法啟動 解決方法 ->重新安裝papermod主題
# 因為模組不會上傳到github 所以需要重新安裝
rm -rf themes/hugo-PaperMod && git clone https://github.com/adityatelange/hugo-PaperMod.git themes/hugo-PaperMod

# hugo version should over 0.146 
brew update
brew upgrade hugo      # 自動升級到最新版（含 extended）
hugo version           # 確認 ≥ 0.146.0


# 重新啟動hugo server
hugo server -D

# 要設定東西 去config.yml 設定
