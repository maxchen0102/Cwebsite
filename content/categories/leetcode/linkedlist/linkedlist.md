---
title: "鏈表（Linked List）：動態數據結構的基石"
date: 2023-08-20
categories: ["leetcode", "資料結構", "演算法"]
tags: ["linkedlist", "雜湊表", "資料結構", "leetcode", "進階技巧"]
description: "探索雜湊表的進階應用技巧，掌握解決複雜 LeetCode 問題的策略，提升您的算法解題能力。"
---

# 鏈表（Linked List）

鏈表是一種常見的線性數據結構，它通過「節點」將數據元素順序連接。與數組不同，鏈表中的元素在內存中不必連續存儲，而是通過指針或引用彼此相連。

## 鏈表的基本結構

每個鏈表節點包含兩部分：
1. **數據域**：存儲節點的值
2. **指針域**：指向下一個節點的引用

```
+-------------+    +-------------+    +-------------+
| 數據 | 下一個 |--->| 數據 | 下一個 |--->| 數據 | 下一個 |--->NULL
+-------------+    +-------------+    +-------------+
```

## 鏈表的種類

### 1. 單向鏈表（Singly Linked List）

每個節點只有一個指向下一節點的指針。

```
Head -> [Data|Next] -> [Data|Next] -> [Data|Next] -> NULL
```

### 2. 雙向鏈表（Doubly Linked List）

每個節點有兩個指針，分別指向前一個和後一個節點。

```
NULL <- [Prev|Data|Next] <-> [Prev|Data|Next] <-> [Prev|Data|Next] -> NULL
        ^
        |
       Head
```

### 3. 循環鏈表（Circular Linked List）

最後一個節點指向第一個節點，形成一個環。

```
     +------------------------------------------+
     |                                          |
     v                                          |
    Head -> [Data|Next] -> [Data|Next] -> [Data|Next]
```

## 鏈表操作的時間複雜度

| 操作      | 單向鏈表 | 雙向鏈表 |
|-----------|---------|---------|
| 訪問元素   | O(n)    | O(n)    |
| 在頭部插入 | O(1)    | O(1)    |
| 在尾部插入 | O(n)/O(1)* | O(1)  |
| 在中間插入 | O(n)    | O(n)    |
| 刪除節點   | O(n)    | O(1)**  |

\* 如果保存了尾指針
\** 已知節點位置的情況下

## 鏈表的優缺點

### 優點
- 動態大小（可以根據需要擴展）
- 高效的插入和刪除操作（與數組相比）
- 不需要連續的內存空間
- 實現某些高級數據結構（如堆棧、隊列、圖）的基礎

### 缺點
- 不支持隨機訪問（無法通過索引直接訪問）
- 每個節點需要額外的內存存儲指針
- 在遍歷過程中時間效率較低（與數組相比）
- 不適合需要頻繁隨機訪問的場景

## 實現示例（Java）

### 單向鏈表的實現

```java
public class SinglyLinkedList<T> {
    // 節點定義
    private class Node {
        T data;
        Node next;
        
        Node(T data) {
            this.data = data;
            this.next = null;
        }
    }
    
    private Node head;
    private int size;
    
    // 建構函數
    public SinglyLinkedList() {
        head = null;
        size = 0;
    }
    
    // 在列表頭部添加節點
    public void addFirst(T data) {
        Node newNode = new Node(data);
        newNode.next = head;
        head = newNode;
        size++;
    }
    
    // 在列表尾部添加節點
    public void addLast(T data) {
        Node newNode = new Node(data);
        
        if (head == null) {
            head = newNode;
        } else {
            Node current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
        size++;
    }
    
    // 刪除第一個節點
    public T removeFirst() {
        if (head == null) throw new NoSuchElementException();
        
        T data = head.data;
        head = head.next;
        size--;
        return data;
    }
    
    // 獲取列表大小
    public int size() {
        return size;
    }
    
    // 檢查列表是否為空
    public boolean isEmpty() {
        return head == null;
    }
    
    // 列印列表
    public void printList() {
        Node current = head;
        while (current != null) {
            System.out.print(current.data + " -> ");
            current = current.next;
        }
        System.out.println("NULL");
    }
}
```

### 雙向鏈表的實現

```java
public class DoublyLinkedList<T> {
    // 節點定義
    private class Node {
        T data;
        Node next;
        Node prev;
        
        Node(T data) {
            this.data = data;
            this.next = null;
            this.prev = null;
        }
    }
    
    private Node head;
    private Node tail;
    private int size;
    
    // 建構函數
    public DoublyLinkedList() {
        head = null;
        tail = null;
        size = 0;
    }
    
    // 在列表頭部添加節點
    public void addFirst(T data) {
        Node newNode = new Node(data);
        
        if (head == null) {
            head = newNode;
            tail = newNode;
        } else {
            newNode.next = head;
            head.prev = newNode;
            head = newNode;
        }
        size++;
    }
    
    // 在列表尾部添加節點
    public void addLast(T data) {
        Node newNode = new Node(data);
        
        if (tail == null) {
            head = newNode;
            tail = newNode;
        } else {
            tail.next = newNode;
            newNode.prev = tail;
            tail = newNode;
        }
        size++;
    }
    
    // 獲取列表大小
    public int size() {
        return size;
    }
    
    // 列印列表（從頭到尾）
    public void printForward() {
        Node current = head;
        while (current != null) {
            System.out.print(current.data + " <-> ");
            current = current.next;
        }
        System.out.println("NULL");
    }
    
    // 列印列表（從尾到頭）
    public void printBackward() {
        Node current = tail;
        while (current != null) {
            System.out.print(current.data + " <-> ");
            current = current.prev;
        }
        System.out.println("NULL");
    }
}
```

## 實際應用場景

1. **瀏覽器歷史記錄**：使用雙向鏈表實現前進和後退功能
2. **音樂播放列表**：歌曲之間的跳轉和循環
3. **操作系統中的任務調度**
4. **圖像處理中的多級撤銷功能**
5. **散列表中解決衝突的鏈接法**
6. **實現堆棧、隊列、LRU快取等高級數據結構**

## LeetCode常見鏈表題目

鏈表是面試中常見的考題類型，以下是一些常見的LeetCode鏈表題目：

1. 反轉鏈表（206）
2. 檢測循環鏈表（141）
3. 合併兩個有序鏈表（21）
4. 刪除鏈表的倒數第N個節點（19）
5. 鏈表的中間節點（876）

## 總結

鏈表是一種靈活的數據結構，適用於需要頻繁插入和刪除操作的場景。儘管它在隨機訪問方面效率較低，但在某些特定應用中具有明顯優勢。理解鏈表的工作原理和實現細節，對於解決複雜問題和設計高效算法至關重要。

在實際應用中，我們需要根據具體問題的需求，在數組和鏈表之間做出適當的選擇。有時，結合兩種數據結構的混合實現，可以獲得最佳性能。 
