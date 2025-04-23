---
title: "雜湊表進階應用 - 解決複雜 LeetCode 問題"
date: 2023-09-20T15:00:00+08:00
draft: false
categories: ["leetcode", "資料結構", "演算法"]
tags: ["hashtable", "雜湊表", "資料結構", "leetcode", "進階技巧"]
description: "探索雜湊表的進階應用技巧，掌握解決複雜 LeetCode 問題的策略，提升您的算法解題能力。"
---

# 雜湊表進階應用

在[上一篇文章](./index.md)中，我們介紹了雜湊表的基本原理和常見應用。本文將進一步探討雜湊表的進階應用，幫助您解決更複雜的 LeetCode 問題。

## 與其他資料結構結合使用

雜湊表往往不是單獨使用，而是與其他資料結構結合，發揮更強大的功能。

### 雜湊表 + 堆（Heap）

**[LeetCode 347. Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/)**

找出數組中出現頻率最高的 k 個元素。

```python
def topKFrequent(nums, k):
    # 使用雜湊表計算頻率
    counter = {}
    for num in nums:
        counter[num] = counter.get(num, 0) + 1
    
    # 使用堆找出頻率最高的 k 個元素
    import heapq
    return heapq.nlargest(k, counter.keys(), key=lambda x: counter[x])
```

### 雜湊表 + 鏈結串列

**[LeetCode 146. LRU Cache](https://leetcode.com/problems/lru-cache/)**

實現一個 LRU (Least Recently Used) 快取機制。

```python
class DLinkedNode:
    def __init__(self, key=0, value=0):
        self.key = key
        self.value = value
        self.prev = None
        self.next = None

class LRUCache:
    def __init__(self, capacity: int):
        self.cache = {}  # 雜湊表：快速查找節點
        self.size = 0
        self.capacity = capacity
        self.head, self.tail = DLinkedNode(), DLinkedNode()  # 虛擬頭尾節點
        self.head.next = self.tail
        self.tail.prev = self.head
    
    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1
        node = self.cache[key]
        self._move_to_head(node)
        return node.value
    
    def put(self, key: int, value: int) -> None:
        if key not in self.cache:
            node = DLinkedNode(key, value)
            self.cache[key] = node
            self._add_to_head(node)
            self.size += 1
            if self.size > self.capacity:
                removed = self._remove_tail()
                del self.cache[removed.key]
                self.size -= 1
        else:
            node = self.cache[key]
            node.value = value
            self._move_to_head(node)
    
    def _add_to_head(self, node):
        node.prev = self.head
        node.next = self.head.next
        self.head.next.prev = node
        self.head.next = node
    
    def _remove_node(self, node):
        node.prev.next = node.next
        node.next.prev = node.prev
    
    def _move_to_head(self, node):
        self._remove_node(node)
        self._add_to_head(node)
    
    def _remove_tail(self):
        node = self.tail.prev
        self._remove_node(node)
        return node
```

## 多重雜湊表技巧

### 巢狀雜湊表

**[LeetCode 49. Group Anagrams](https://leetcode.com/problems/group-anagrams/)**

將字母異位詞分組。

```python
def groupAnagrams(strs):
    anagram_groups = {}
    for s in strs:
        # 將字串排序作為雜湊表的鍵
        sorted_s = ''.join(sorted(s))
        if sorted_s not in anagram_groups:
            anagram_groups[sorted_s] = []
        anagram_groups[sorted_s].append(s)
    
    return list(anagram_groups.values())
```

### 雙雜湊表

**[LeetCode 3. Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/)**

尋找無重複字符的最長子串。

```python
def lengthOfLongestSubstring(s):
    char_index = {}  # 記錄字符最後出現的位置
    max_length = 0
    start = 0
    
    for i, char in enumerate(s):
        if char in char_index and char_index[char] >= start:
            start = char_index[char] + 1
        else:
            max_length = max(max_length, i - start + 1)
        
        char_index[char] = i
    
    return max_length
```

## 前綴和 + 雜湊表

**[LeetCode 560. Subarray Sum Equals K](https://leetcode.com/problems/subarray-sum-equals-k/)**

找出和等於 k 的連續子數組個數。

```python
def subarraySum(nums, k):
    count = 0
    sum_so_far = 0
    prefix_sums = {0: 1}  # 前綴和:出現次數
    
    for num in nums:
        sum_so_far += num
        if sum_so_far - k in prefix_sums:
            count += prefix_sums[sum_so_far - k]
        
        prefix_sums[sum_so_far] = prefix_sums.get(sum_so_far, 0) + 1
    
    return count
```

## 雜湊表在串列問題中的應用

**[LeetCode 138. Copy List with Random Pointer](https://leetcode.com/problems/copy-list-with-random-pointer/)**

深度拷貝一個帶有隨機指針的鏈結串列。

```python
def copyRandomList(head):
    if not head:
        return None
    
    # 第一次遍歷：創建所有新節點，並建立映射關係
    old_to_new = {}
    current = head
    while current:
        old_to_new[current] = Node(current.val)
        current = current.next
    
    # 第二次遍歷：設置新節點的 next 和 random 指針
    current = head
    while current:
        old_to_new[current].next = old_to_new.get(current.next)
        old_to_new[current].random = old_to_new.get(current.random)
        current = current.next
    
    return old_to_new[head]
```

## 雜湊表與位運算結合

**[LeetCode 136. Single Number](https://leetcode.com/problems/single-number/)**

找出數組中只出現一次的數字（其他數字都出現兩次）。

```python
# 使用雜湊表解法
def singleNumber(nums):
    num_count = {}
    for num in nums:
        num_count[num] = num_count.get(num, 0) + 1
    
    for num, count in num_count.items():
        if count == 1:
            return num

# 使用位運算（XOR）解法 - 更高效
def singleNumber_optimized(nums):
    result = 0
    for num in nums:
        result ^= num
    return result
```

## 雜湊表在圖論問題中的應用

**[LeetCode 133. Clone Graph](https://leetcode.com/problems/clone-graph/)**

深度拷貝一個無向圖。

```python
def cloneGraph(node):
    if not node:
        return None
    
    # 使用雜湊表記錄已複製的節點
    visited = {}
    
    def dfs(original):
        if original in visited:
            return visited[original]
        
        # 創建新節點
        copy = Node(original.val)
        visited[original] = copy
        
        # 複製所有鄰居
        for neighbor in original.neighbors:
            copy.neighbors.append(dfs(neighbor))
        
        return copy
    
    return dfs(node)
```

## 雜湊表的效能優化技巧

### 合理選擇鍵的類型

選擇合適的鍵類型可以大幅提高雜湊表的效率：

- 簡單數據類型（整數、字符等）通常有更高效的雜湊函數
- 對於複雜對象，確保其雜湊方法實現得當
- 對於需要比較順序的情況，考慮使用有序雜湊表（如 Python 的 OrderedDict）

### 處理碰撞的進階技術

- **再雜湊法（Double Hashing）**：使用第二個雜湊函數來計算步長
- **羅賓漢雜湊（Robin Hood Hashing）**：基於元素的"貧富差距"調整位置
- **杜魯門雜湊（Cuckoo Hashing）**：使用多個雜湊函數和多個表

## 自訂雜湊函數

在某些情況下，我們需要為自定義對象設計雜湊函數。以 Python 為例：

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def __eq__(self, other):
        if not isinstance(other, Point):
            return False
        return self.x == other.x and self.y == other.y
    
    def __hash__(self):
        return hash((self.x, self.y))

# 使用 Point 對象作為雜湊表的鍵
points = {}
points[Point(1, 2)] = "Point A"
points[Point(3, 4)] = "Point B"
```

## 總結

雜湊表是解決複雜 LeetCode 問題的強大工具，特別是當與其他資料結構結合使用時。掌握這些進階應用技巧，將幫助您更有效地解決演算法難題。

關鍵要點：
1. 學會將雜湊表與其他資料結構結合使用
2. 掌握前綴和等技巧與雜湊表的聯合應用
3. 了解雜湊表在圖論和鏈結串列問題中的應用
4. 使用適當的技巧優化雜湊表的效能

希望這篇文章能幫助您在 LeetCode 的解題過程中更靈活地運用雜湊表！ 
