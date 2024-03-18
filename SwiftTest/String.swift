//
//  String.swift
//  SwiftTest
//
//  Created by 张延杰 on 2024/1/15.
//  Copyright © 2024 leeco. All rights reserved.
//

// 共8题
import Foundation

// 1.一个字符串中只出现一次且是第一个的字符
func firstUniqChar(_ s: String) -> Character {
    var dict = [Character:Int]()
    let strArr = Array(s)
    for str in strArr {
        if dict[str] == nil {
            dict[str] = 0
        }
        dict[str]! += 1
    }
    for str in strArr {
        if dict[str] == 1 {
            return str
        }
    }
    return Character(" ")
}

// 2.是否为有效的ip
func validIPAddress(_ queryIP: String) -> Bool {
    let arr = queryIP.components(separatedBy: ".")
    if arr.count != 4 {
        return false
    }
    for i in 0..<arr.count {
        
        if Int(arr[i])! > 255 || Int(arr[i])! < 0{
            return false
        }
        if Int(arr[i])! != 0 {
            let chars = Array(arr[i])
            if chars.first == "0" {
                return false
            }
        }
        
    }
    return true
}

// 3.有效的字母异位词
// 若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。
func isAnagram(_ s: String, _ t: String) -> Bool {
    
    let sArr = s.map({String($0)})
    let tArr = t.map({String($0)})
    
    if sArr.count != tArr.count {
        return false
    }
    
    var sDict = [String:Int]()
    var tDict = [String:Int]()
    for sStr in sArr {
        if sDict[sStr] == nil {
            sDict[sStr] = 1
        } else {
            sDict[sStr] = sDict[sStr]! + 1
        }
    }
    for tStr in tArr {
        if tDict[tStr] == nil {
            tDict[tStr] = 1
        } else {
            tDict[tStr] = tDict[tStr]! + 1
        }
    }
    
    for (key,value) in sDict {
        if tDict[key] != value {
            return false
        }
    }
    
    return true
}

// 4.最长公共前缀   输入：strs = ["flower","flow","flight"]   输出："fl"
func longestCommonPrefix(_ strs: [String]) -> String {
    if strs.count == 0{
        return ""
    }
    if strs.count == 1{
        return strs[0]
    }
    
    var commonprefix = strs[0]
    for i in 1..<strs.count-1 {
        commonprefix = commonPrefix(commonprefix, strs[i])
    }
    return commonprefix
}

func commonPrefix(_ str1 : String ,_ str2:String) -> String {
    var result = ""
    var index = 0;
    let arr1 = str1.map({String($0)})
    let arr2 = str2.map({String($0)})
    while arr1[index]==arr2[index] {
        result.append(contentsOf: arr1[index])
        index += 1
    }
    return result
}

// 5.最长回文子串    babcdcb -> bcdcb
// 首先定义一个BOOL类型的二维数组，数组的对角线都是true
// 从字符串的最小的长度开始遍历,将dp[i][j]填满
func longestPalindrome (_ s: String) -> String {
    
    if s.count < 2 {return s}
    
    let arr = s.map({String($0)})
    // dp[i][j]表示从第i个开始到第j个结束的子串是否是回文子串
    // 如果s[i]=s[j], 就看s[i+1]和s[j-1]是否是回文子串
    // 如果s[i]！=s[j], 不是回文子串
    let boolArr = [Bool](repeating: false, count: s.count)
    var dp = [[Bool]](repeating: boolArr, count: s.count)
    
    // 对角线上的都是true
    for i in 0..<arr.count {
        dp[i][i] = true;
    }
    
    var start = 0 // 记录开始位置
    var maxLen = 1 // 记录最大长度
    // 从最小长度的开始遍历
    for L in 2..<arr.count+1 {
        for i in 0..<arr.count {
            let j = L+i-1
            
            if j>=arr.count {
                break
            }
            if(arr[i] == arr[j]) {
                if (j-i<3) {
                    dp[i][j]=true;
                } else {
                    dp[i][j] = dp[i+1][j-1]
                }
                
            } else {
                dp[i][j] = false
            }
            
            if(dp[i][j] && j-i>maxLen) {
                maxLen = j-i
                start = i
            }
            print("i=",i,",j=",j," dp[i][j]=",dp[i][j])
        }
    }
    return arr[start...start+maxLen].joined()
    
}

// 6. 无重复字符的最长子串
// s = "abcabcbb"    因为无重复字符的最长子串是 "abc"，所以其长度为 3。
func lengthOfLongestSubstring(_ s: String) -> Int {
    // 1. 首先定义一个字典和一个无重复字符的起始位置
    var dict = [Character:Int]()
    var startIndex = 0
    var result = 0

    // 2.遍历字符串，如果之前出现过，start指针就指向出现的index+1
    for (idex,char) in s.enumerated() {
        if let preIndex = dict[char] {
            startIndex = preIndex+1
        }
        dict[char] = idex
        // 3.记录当前index和startIndex之间的长度
        result = max(result, idex-startIndex+1)
    }
    
    return result
    
}

// 7.有效的括号
func isValid(_ s: String) -> Bool {
    if s.count < 2 {
        return false
    }
    let arr = s.map({String($0)})
    var resultArr = [String]()
    let dict = [")":"(","]":"[","}":"{"]
    for str in arr {
        if str == "(" || str == "[" || str == "{" {
            resultArr.append(str)
        } else if str == ")" || str == "]" || str == "}" {
            if dict[str] == resultArr.last {
                _ = resultArr.popLast()
            } else {
                resultArr.append(str)
            }
        }
        
    }
    return resultArr.count == 0
}

// 8. 正则表达式匹配    给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。
// '.' 匹配任意单个字符
// '*' 匹配零个或多个前面的那一个元素
// 思路：比较前两个字符，递归比较
func isMatch(_ s: String, _ p: String) -> Bool {
    if s.count == 0 || p.count == 0 {
        return false
    }
    return match(s,0,p,0)
}

func match(_ s: String,_ i: Int, _ p: String, _ j: Int) -> Bool {
    if s.count == i && p.count == j { //都为空
        return true
    }
    
    if i<s.count && j == p.count {
        // 模式串为空了
        return false
    }
    var strArr = s.map({String($0)})
    var patterArr = p.map({String($0)})
    // 第二个字符串不是*
    if j+1<patterArr.count && patterArr[j+1] != "*" {
        // 第一个字符相等，直接比较下一个
        if strArr[i]==patterArr[j] || patterArr[j]=="." {
            return match(s,i+1,p,j+1)
        }
    } else {
        // 第二个字符串是*
        // 第一个字符不相等
        if strArr[i] != patterArr[j] && patterArr[j] != "." {
            return match(s,i,p,j+2)
        } else {
            // 第一个字符相等
            // 有三种情况：1.即使第一个相等，*如果是1则j往后移动两位   2.第一个相等，则i往后移动1位，j可移动2位也可不移动
            return match(s,i,p,j+2) || match(s,i+1,p,j+2) || match(s,i+1,p,j);
        }
    }
    return false
}

// 8.括号的生成
// 输入：n = 3
// 输出：["((()))","(()())","(())()","()(())","()()()"]
//var cache = [Int:[String]]()
//func generateParenthesis(_ n: Int) -> [String] {
//    var result = [String]()
//
//
//    return result
//}
//
//func generate(_ n: Int) -> [String] {
//    if cache[n] != nil {
//        return cache[n] ?? [String]()
//    }
//    var result = [String]()
//    if n == 0 {
//        result.append("")
//    } else {
//        for i in 0..<n {
//            for
//        }
//    }
//
//    return result
//}
