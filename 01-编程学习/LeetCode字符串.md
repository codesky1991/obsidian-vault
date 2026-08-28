---
created: 2024
title: LeetCode字符串面试题
tags:
  - 算法
  - LeetCode
  - 面试
aliases: [字符串算法, 滑动窗口]
source: Hugo博客迁移
related:
  - 后台开发
---

# LeetCode字符串面试题

## 无重复字符的最长子串

**LeetCode 3**: 给定一个字符串，找出其中不含重复字符的最长子串的长度。

### 方法一：暴力遍历

```python
def length_of_longest_substring(s: str) -> int:
    n = len(s)
    ans = 0

    for i in range(n):
        for j in range(i + 1, n + 1):
            if len(set(s[i:j])) == (j - i):
                ans = max(ans, j - i)

    return ans
```

**时间复杂度**: O(n³)
**空间复杂度**: O(min(n, m))，m 为字符集大小

### 方法二：滑动窗口（推荐）

```python
def length_of_longest_substring(s: str) -> int:
    chars = {}
    left = 0
    ans = 0

    for right, char in enumerate(s):
        if char in chars:
            # 更新左边界
            left = max(left, chars[char] + 1)

        chars[char] = right
        ans = max(ans, right - left + 1)

    return ans
```

**时间复杂度**: O(n)
**空间复杂度**: O(min(n, m))

### 图解

```
字符串: "abcabcbb"

滑动过程:
a b c a b c b b
^ ^
left=0, right=0, chars={a:0}, ans=1

a b c a b c b b
^   ^
left=0, right=1, chars={a:0,b:1}, ans=2

a b c a b c b b
^     ^
left=0, right=2, chars={a:0,b:1,c:2}, ans=3

a b c a b c b b
  ^     ^
当遇到第二个 'a' 时，left 更新为 1
```

## 相关笔记

- [[后台开发]]
- [[面试经验]]
