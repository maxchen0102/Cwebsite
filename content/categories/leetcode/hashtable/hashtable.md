---
title: "哈希表（Hash Table）：高效能的鍵值對數據結構"
date: 2025-04-23T14:57:00+0800
categories: ["leetcode", "資料結構", "演算法"]
tags: ["hashtable", "雜湊表", "資料結構", "leetcode", "進階技巧"]
description: "探索雜湊表的進階應用技巧，掌握解決複雜 LeetCode 問題的策略，提升您的算法解題能力。"
---

# 哈希表（Hash Table）

哈希表是一種高效率的數據結構，能夠以接近 O(1) 的時間複雜度進行數據查找、插入和刪除操作。它廣泛應用於數據庫索引、快取系統、符號表等場景，是現代編程中最重要的數據結構之一。

## 基本原理

哈希表基於「鍵值對」（key-value pair）的概念，它使用一個特殊的函數（哈希函數）將鍵轉換為數組索引，然後將值存儲在該索引位置。

### 核心組件

1. **哈希函數**：將鍵轉換為數組索引的函數
2. **數組**：存儲數據的物理結構
3. **衝突解決策略**：處理不同鍵產生相同索引的情況

## 哈希函數

好的哈希函數應當滿足以下特性：
- 計算速度快
- 分布均勻，最小化衝突
- 確定性，相同輸入產生相同輸出

一個簡單的哈希函數示例（針對字符串）：

```c
int hash(char* key, int table_size) {
    unsigned int hash_value = 0;
    while (*key) {
        hash_value = (hash_value * 31) + *key++;
    }
    return hash_value % table_size;
}
```

## 衝突解決

當兩個不同的鍵產生相同的哈希值（稱為「衝突」）時，我們需要有策略來解決這個問題：

### 1. 鏈接法（Chaining）

每個數組位置存儲一個鏈表，所有哈希到同一位置的元素都放入這個鏈表中。

```
[0] -> (key1, value1) -> (key4, value4)
[1] -> (key2, value2)
[2] -> (key3, value3) -> (key5, value5) -> (key6, value6)
```

### 2. 開放尋址法（Open Addressing）

當發生衝突時，查找數組中的另一個位置來存儲元素。常見的方法有：

- **線性探測**：檢查下一個位置，再下一個，依此類推
- **二次探測**：使用二次函數計算探測序列
- **雙重哈希**：使用第二個哈希函數計算步長

## 哈希表操作的時間複雜度

| 操作 | 平均情況 | 最壞情況 |
|------|----------|----------|
| 查找 | O(1)     | O(n)     |
| 插入 | O(1)     | O(n)     |
| 刪除 | O(1)     | O(n)     |

最壞情況發生在所有鍵都哈希到同一位置時。

## 實現示例（JavaScript）

以下是一個簡單的哈希表實現：

```javascript
class HashTable {
  constructor(size = 53) {
    this.keyMap = new Array(size);
  }
  
  _hash(key) {
    let total = 0;
    let PRIME = 31;
    for (let i = 0; i < Math.min(key.length, 100); i++) {
      let char = key[i];
      let value = char.charCodeAt(0) - 96;
      total = (total * PRIME + value) % this.keyMap.length;
    }
    return total;
  }
  
  set(key, value) {
    let index = this._hash(key);
    if (!this.keyMap[index]) {
      this.keyMap[index] = [];
    }
    this.keyMap[index].push([key, value]);
  }
  
  get(key) {
    let index = this._hash(key);
    if (this.keyMap[index]) {
      for (let i = 0; i < this.keyMap[index].length; i++) {
        if (this.keyMap[index][i][0] === key) {
          return this.keyMap[index][i][1];
        }
      }
    }
    return undefined;
  }
  
  keys() {
    let keysArr = [];
    for (let i = 0; i < this.keyMap.length; i++) {
      if (this.keyMap[i]) {
        for (let j = 0; j < this.keyMap[i].length; j++) {
          if (!keysArr.includes(this.keyMap[i][j][0])) {
            keysArr.push(this.keyMap[i][j][0]);
          }
        }
      }
    }
    return keysArr;
  }
  
  values() {
    let valuesArr = [];
    for (let i = 0; i < this.keyMap.length; i++) {
      if (this.keyMap[i]) {
        for (let j = 0; j < this.keyMap[i].length; j++) {
          if (!valuesArr.includes(this.keyMap[i][j][1])) {
            valuesArr.push(this.keyMap[i][j][1]);
          }
        }
      }
    }
    return valuesArr;
  }
}

// 使用示例
const ht = new HashTable();
ht.set("红色", "#FF0000");
ht.set("藍色", "#0000FF");
ht.set("綠色", "#00FF00");
ht.get("藍色"); // 返回 "#0000FF"
```

## 哈希表優化策略

1. **負載因子控制**：當元素數量與表大小的比值（負載因子）超過閾值時，需要擴容並重新哈希
2. **好的哈希函數**：選擇分布均勻的哈希函數
3. **適當的初始容量**：根據預計數據量設置初始容量

## 常見應用

1. **數據庫索引**：快速查找記錄
2. **快取系統**：如 Redis、Memcached
3. **集合（Set）的實現**：檢查成員資格
4. **計數器**：例如統計單詞頻率
5. **關聯數組/字典**：如 JavaScript 的物件、Python 的字典

## 總結

哈希表通過空間換時間的方式，實現了極高效率的數據存取。理解哈希表的工作原理和實現細節，對於開發高性能應用至關重要。在選擇數據結構時，如果需要快速查找、插入、刪除操作，且數據具有鍵值對特性，哈希表通常是最佳選擇。 
