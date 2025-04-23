---
title: "RESTful API 設計最佳實踐"
date: 2023-10-18T14:30:00+08:00
draft: false
categories: ["api-design"]
tags: ["rest", "api", "http"]
---

# RESTful API 設計最佳實踐

良好的 API 設計可以提高開發效率、改善用戶體驗並減少錯誤。本文將分享一些 RESTful API 設計的最佳實踐。

## URL 結構設計

RESTful API 應使用直觀的 URL 結構，以資源為中心：

```
# 好的設計
GET /users          # 獲取所有用戶
GET /users/123      # 獲取特定用戶
POST /users         # 創建新用戶
PUT /users/123      # 更新用戶
DELETE /users/123   # 刪除用戶

# 避免的設計
GET /getUsers
POST /createUser
```

## HTTP 方法的正確使用

每個 HTTP 方法都有特定用途：

- **GET**：讀取資源
- **POST**：創建新資源
- **PUT**：完全更新資源
- **PATCH**：部分更新資源
- **DELETE**：刪除資源

## 狀態碼

正確使用 HTTP 狀態碼可以提供明確的回應：

- **2xx**：成功
  - 200 OK：請求成功
  - 201 Created：資源創建成功
  - 204 No Content：請求成功但無返回內容

- **4xx**：客戶端錯誤
  - 400 Bad Request：請求格式錯誤
  - 401 Unauthorized：未授權
  - 404 Not Found：資源不存在

- **5xx**：服務器錯誤
  - 500 Internal Server Error：服務器內部錯誤

## 版本控制

API 版本控制有多種方式：

```
# URL 路徑版本
/api/v1/users

# 請求頭版本
Accept: application/vnd.company.v1+json
```

## 文檔化

好的 API 需要完整的文檔。考慮使用 Swagger/OpenAPI 來自動生成文檔。

## 結論

遵循 RESTful 設計原則，可以創建出易於理解、使用和維護的 API。記住，良好的設計應該優先考慮簡單性和一致性。 
