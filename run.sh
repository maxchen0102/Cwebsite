#!/bin/bash

# 你想用的 port 號
PORT=1313

# 自動開啟瀏覽器（支援 macOS，其他平台也可改）
open "http://localhost:$PORT"

# 啟動 Hugo 並指定 port
hugo server --port $PORT --bind 127.0.0.1