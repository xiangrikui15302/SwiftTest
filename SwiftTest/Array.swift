//
//  数组.swift
//  SwiftTest
//
//  Created by 回旋工作者 on 2023/8/10.
//  Copyright © 2023 leeco. All rights reserved.
//

// 共23题
import Foundation

// 1. 两个数的和
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var num = 0
    var dict:[Int:Int] = [:]
    var result:[Int] = []
    for i in 0..<nums.count {
        var current = nums[i]
        num = target - current
        if (dict[num] == nil) {
            dict[current] = i
        } else {
            result.append(dict[num]!)
            result.append(i)
            return result
        }
        
    }
    return result
}

// 2. 已排序的数组二分查找
func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {
    if matrix.count == 0 {
        return false
    }
    if matrix[0][0]>target {
        return false
    }
    for arr in matrix {
        if sencondSearch(arr,0,arr.count-1,target) {
            return true
        }
    }
    return false
    
}

// 3. 二分查找
func sencondSearch(_ arr:[Int],_ left:Int,_ right:Int,_ target:Int) -> Bool {
    if arr[left] == target || arr[right] == target {
        return true
    }else if left == right {
        return false
    }
    
    var middle = (left + right)/2
    if arr[middle] > target {
        return sencondSearch(arr,left,middle,target)
    } else if arr[middle] < target {
        return sencondSearch(arr,middle+1,right,target)
    } else {
        return true
    }
}

// 4. 连续子数组的最大和 [-2,1,-3,4,-1,2,1,-5,4]
func maxSubArray(_ nums: [Int]) -> Int {
    var maxSub = Int.min
    var subNum = Int.min
    for num in nums {
        subNum = max(subNum+num, num)
        maxSub = max(maxSub, subNum)
    }
    return maxSub
    
}

// 5. 长度最小的子数组   滑动窗口
// 给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的 连续 子数组，并返回其长度。如果不存在符合条件的子数组，返回 0。
// s = 8, nums = [2,3,1,2,4,5]   [4,3] 所以返回2
func minSubArrayLen(_ nums : [Int],_ target:Int) -> Int {
    var queue = [Int]()
    // 滑动窗口中的所有的和
    var sum = 0
    var minCount = Int.max
    for num in nums {
        queue.append(num)
        sum += num

        while sum >= target {
            minCount = min(minCount, queue.count)
            sum -= queue.removeFirst()
        }
        
    }
    return minCount == Int.max ? 0 :minCount
}

// 6. 快乐数   平方和最终为1
// 输入：19
//    输出：true
//    解释： 如果平方和相加之后的数之前出现过，那就会无限循环(用字典存储)
//    1^2 + 9^2 = 82
//    8^2 + 2^2 = 68
//    6^2 + 8^2 = 100
//    1^2 + 0^2 + 0^2 = 1
func isHappy(_ n:Int) -> Bool {
    var set = Set<Int>()
    var num = n
    while true {
        var sumNum = getSum(num)
        if sumNum == 1 {
            return true
        }
        if set.contains(sumNum) {
            return false
        }
        set.insert(sumNum)
        num = sumNum
    }
    
}
// 7. 每个位置上的数字的平方和
func getSum(_ n:Int) -> Int {
    var sum = 0
    var number = n
    while number > 0 {
        var num = number%10
        sum += num*num
        number = number/10
    }
    return sum
}

// 8. 有序二维数组查找
func findNum(target:Int,_ arr:[[Int]]) -> Bool{
    if(arr.count == 0) {
        return false
    }
    if(arr[0].count == 0) {
        return false
    }
    
    var allArr = arr
    var firstRow = arr[0]
    
    while allArr.count > 0 && allArr[0].count > 0 {
        firstRow = allArr[0]
        if firstRow.last == target {
            return true
        } else if firstRow.last! > target {
            // 最后一个比target大，去掉最后一列，查找前面的
            allArr = allArr.map { row in
                var row = row
                row.removeLast()
                return row
            }
        } else {
            // 最后一个比target小，去掉第一行，查找后面的
            allArr.removeFirst()
        }
        
    }
    return false
    
    
}

// 9. 移除元素  快慢指针  快指针不等于num时赋值给慢指针
// [0,1,2,2,3,0,4,2]  , 2   返回[0, 1, 3, 0, 4]   5
func removeElement(_ arr:inout [Int], _ num:Int) -> Int {
    
    var slowIndex = 0
    for fastIndex in 0..<arr.count {
        if arr[fastIndex] != num {
            // 如果需要输出这个数组就将这句加上
//            arr[slowIndex] = arr[fastIndex]
            slowIndex += 1
        }
    }
    return slowIndex
}

// 10. 找到数组中第二大的数
// arr = [1,3,5,0,4,5,2]   输出4
func getSecondMax(_ arr:[Int]) -> Int {
    if arr.count < 2 {
        return Int.min
    }
    
    var maxNum = arr[0]
    var second = Int.min;
    for num in arr {
        maxNum = max(maxNum, num)
        if num<maxNum && num > second {
            second = num
        }
    }
    
    return second
}

// 11. 有序数组的平方   前后指针
// nums = [-4,-1,0,3,10]  输出[0,1,9,16,100]
func sortedSquares(_ arr:[Int]) -> [Int] {
    var result = arr
    var beginIndex = 0
    var endIndex = arr.count-1
    var index = arr.count - 1
    while beginIndex <= endIndex {
        if(abs(beginIndex) > abs(endIndex)) {
            result[index] = abs(beginIndex)*abs(beginIndex)
            beginIndex += 1
        }else {
            result[index] = abs(endIndex)*abs(endIndex)
            endIndex -= 1
        }
        index -= 1
        
    }
    return result
}


// 12. 旋转数组中的最小值     [3,4,5,1,2]
// 非减排序的数组旋转   即原来这个数组要么是递增要么是相等的，要么是无序的
func minNumberInRotateArray(_ arr:[Int]) -> Int {
    if arr.count == 0 {return 0}
    var low = 0
    var high = arr.count - 1
    
    /*
    三种情况:
     (1)把前⾯0个元素搬到末尾，也就是排序数组本身，第一个就是最小值
     (2)一般情况二分查找，当high-low=1时，high就是最⼩值
     (3)如果首尾元素和中间元素都相等时，只能顺序查找
    */
    if arr[low]<arr[high] {
        return arr[low]
    }
    
    while low<high {
        let mid = low + (high - low) / 2
        
        if(arr[low] == arr[mid] && arr[mid] == arr[high]) {
            return minInOrder(arr)
        }
        
        if arr[low] < arr[mid] {
            low = mid
        }
        if arr[high] > arr[mid] {
            high = mid
        }
        
        if(high - low == 1) {
            return arr[high]
        }
    }
    return -1
}

func minInOrder(_ arr: [Int]) -> Int {
    var minNum = arr[0]
    for num in arr {
        minNum = min(num, minNum)
        
    }
    return minNum
}


// 13. 调整数组顺序，使奇数位于偶数前面，且奇数和奇数之间，偶数和偶数之间的相对位置不变
// [2,3,6,4,8,7]   ->    [3,7,2,6,4,8]
func reOrderArray(_ arr : [Int]) -> [Int] {
//    var resultArr = Array.init(repeating: 0, count: arr.count);
    var oddArr = [Int]()
    var evenArr = [Int]()
    for num in arr {
        if num % 2 == 0 {
            oddArr.append(num)
        } else {
            evenArr.append(num)
        }
    }
    evenArr.append(contentsOf: oddArr)
    return evenArr
}

// 14. 顺时针打印矩阵
func printMatrix(_ arr : [[Int]]) -> [Int] {
    var result = [Int]()
    let row = arr.count
    if row == 0 {return result}
    let col = arr[0].count
    var index = 0
    while row > 2*index && col > 2*index {
        let endY = col - index - 1
        let endX = row - index - 1
        
        // 第index行从左到右
        for y in index...endY {
            result.append(arr[index][y])
        }
        
        // 第endY列从上到下
        if (endX > index+1) {
            for x in index+1...endX {
                result.append(arr[x][endY])
            }
        }
        
        // 第endX行从右到左
        if (endY > index+1) {
            for y in (index..<endY).reversed() {
                result.append(arr[endX][y])
            }
        }
        
        // 第index列从下到上
        if (endX-1 > index+1) {
            for x in (index+1...endX-1).reversed() {
                result.append(arr[x][index])
            }
        }
        index += 1
    }
    return result
}

// 15. 把数组排成最小的数
func printMinNumber(_ arr : [Int]) -> String {
    var arrStr = arr.map { item in
        return String(item)
    }
    // mn > nm  说明m>n
    // mn < nm  说明m<n
    // mn = nm  说明m=n
    arrStr = arrStr.sorted { m, n in
        if (m+n) > (n+m) {
            return false
        } else if (m+n) < (n+m) {
            return true
        } else {
            return true
        }
    }
    return arrStr.joined()
}

// 16. 最长连续序列   nums = [100,4,200,1,3,2]   最长为4   即  1,2,3,4
func longestConsecutive(_ nums: [Int]) -> Int {
    
    var maxLen = 0
    if nums.count < 2 {
        return nums.count
    }
    
    var dict = [Int:Int]()
    // 1. 遍历所有元素，保存到字典中
    for i in 0..<nums.count {
        dict[nums[i]] = i
    }
    
    // 2. 遍历数组，以每个元素作为起始点，寻找连续序列
    for num in nums {
        // 保存当前连续序列长度
        var len = 1
        
        // 判断：只有当前元素的前驱不存在的情况下，才去进行寻找连续序列的操作
        if(dict[num-1] == nil) {
            // 保存当前元素作为起始点
            var currentNum = num
            // 寻找后续数字，组成连续序列
            while dict[currentNum+1] != nil {
                len += 1
                currentNum = currentNum+1
            }
        }
        maxLen = max(maxLen, len)
    }
    return maxLen
}



// 17. 盛最多水的容器
// 前后指针 小的那个移动
func maxArea(_ height: [Int]) -> Int {
    var maxArea = 0
    if height.count<2 {
        return maxArea
    }
    var begin = 0
    var end = height.count-1
    while begin<end {
        var x = end-begin
        maxArea = max(maxArea,x*min(height[begin],height[end]))
        if height[begin]<height[end] {
            begin += 1
        } else {
            end -= 1
        }
        
        
    }
    return maxArea
}

// 18. 合并两个有序数组，合并到nums1中
//  m 和 n ，分别表示 nums1 和 nums2 中的元素数目
// 合并 nums2 到 nums1 中，使合并后的数组同样按 非递减顺序 排列
// 三个指针，分别从数组的最后一位开始往前
func merge(_ nums1: inout [Int], _ m1: Int, _ nums2: [Int], _ n1: Int) {
    if n1 == 0 {
        return
    }
    if m1 == 0 {
        nums1.removeAll()
        nums1.append(contentsOf: nums2)
    }
    var end = m1+n1
    var m = m1-1
    var n = n1-1
    while m >= 0 && n >= 0 {
        
        if(nums1[m] > nums2[n]) {
            nums1[end] = nums1[m]
            m-=1
        }else {
            nums1[end] = nums2[n]
            n-=1
        }
        
        end -= 1
    }
    while n >= 0 {
        nums1[end] = nums2[n]
        n-=1
        end -= 1
    }
    
}
// 19. 买卖股票的最佳时机
func maxProfit(_ prices: [Int]) -> Int {
    var lowPrice = Int.max
    var highPrice = 0
    var maxPrice = 0
    for price in prices {
        if price < lowPrice {
            lowPrice = price
            highPrice = 0
        }
        highPrice = max(highPrice,price)
        maxPrice = max(maxPrice,highPrice-lowPrice)
    }
    return maxPrice
}
// 20.寻找两个正序数组的中位数
// 输入：nums1 = [1,2], nums2 = [3,4]
// 输出：2.50000
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    if nums1.count == 0 && nums2.count == 0 {return 0.0}
    var resultArr = [Int]()
    let count = nums1.count + nums2.count
    var index1 = 0
    var index2 = 0
    let middle = count / 2
    for i in 0..<count {
        if index1 >= nums1.count {
            while index2 < nums2.count {
                resultArr.append(nums2[index2])
                index2 += 1
            }
            continue
        }
        
        if index2 >= nums2.count {
            while index1 < nums1.count {
                resultArr.append(nums1[index1])
                index1 += 1
            }
            continue
        }
        
        if nums1[index1] < nums2[index2] {
            resultArr.append(nums1[index1])
            index1 += 1
        } else {
            resultArr.append(nums2[index2])
            index2 += 1
        }
        if i == middle {
            break
        }
    }
    
    if(count == 1) {
        return Double(resultArr[0])
    }
    
    if count % 2 == 0 {
        return Double(resultArr[middle] + resultArr[middle-1])/2.0
    } else {
        return Double(resultArr[middle])
    }
    
}

// 21.数组中出现次数超过一半的数
// 数组中一个数组出现的次数超过数组长度的一半，即它出现的次数比其他所有数字出现次数的和还要多
// count + 1和count - 1   当count == 0的时候，正好折半
func moreThanHalfNumber(_ arr:[Int]) -> Int? {
    if arr.count == 0 {
        return nil
    }
    var target = arr[0]
    var count = 0
    for num in arr {
        if count == 0 {
            target = num
            count = 1
        } else if target == num {
            count += 1
        } else {
            count -= 1
        }
    }
    return target
}

// 22. 统计一个数字在排序数组中出现的次数
// 例如，输入排序数组{1,2,3,3,3,3,4,5}和数字3，由于数字3在该数组中出现了4次，所以函数返回4
// 排序首先想到的是二分查找。即查找第一个k出现的位置和最后一个k出现的位置
// 二分查找第一个，如果中间比k大说明在左边，比k小说明在右边，如果中间的等于k 再看k的前一个是否与k相等，不相等说明当前是第一个，如果相等再看前一个。最后一个的位置同理
func getNumberOfK(_ arr:[Int],_ k:Int) -> Int?{
    var firstIndex = searchFirstOfK(arr,k)
    var lastIndex = searchLastOfK(arr,k)
    if firstIndex == nil || lastIndex == nil {
        return nil
    }
    return lastIndex! - firstIndex! + 1
}

func searchFirstOfK(_ arr:[Int],_ k:Int) -> Int? {
    if arr.count == 0 {
        return nil
    }
    
    var low = 0
    var high = arr.count-1
    while low<=high {
        var mid = low+(high - low)/2
        if arr[mid] < k {
            low = mid
        } else if arr[mid] > k {
            high = mid
        } else {
            // 中间的就是k
            if mid - 1 != 0 {
                while arr[mid-1] == k {
                    mid -= 1
                }
            }
            return mid
        }
    }
    return nil
    
}

func searchLastOfK(_ arr:[Int],_ k:Int) -> Int? {
    if arr.count == 0 {
        return nil
    }
    
    var low = 0
    var high = arr.count-1
    while low<=high {
        var mid = low + (high - low)/2
        if arr[mid] < k {
            low = mid
            
        } else if arr[mid] > k {
            high = mid
        } else {
            // 中间的就是k，看k后面的
            if mid + 1 != arr.count {
                while arr[mid+1] == k {
                    mid += 1
                }
            }
            return mid
        }
    }
    return nil
    
}

// 23. 全排列   [1,2,3]   输出[[1,2,3],[1,3,2],[2,3,1],[2,1,3],[3,1,2],[3,2,1]]
// 采用递归方法，第一步：求所有可能出现在第一个位置的字符，即把第一个字符与后面的字符依次交换。第二步：固定一个字符，求后面所有字符的排列
var permutationResult = [[Int]]()
func full_permutation(_ arr:[Int]) -> [[Int]] {
    
    if arr.count == 0 {
        return permutationResult
    }
    permutation(arr, 0)
    return permutationResult
    
}

func permutation(_ arr:[Int],_ beginIndex:Int) {
    var temp = arr
    if beginIndex == arr.count-1 {
        if !(permutationResult.contains(temp)) {
            permutationResult.append(temp)
        }
    } else {
        for i in beginIndex+1..<arr.count {
            temp.swapAt(beginIndex, i)
            permutation(temp, i+1)
            temp.swapAt(i, beginIndex)
        }
    }
}

// 24. 从1到n整数中1出现的次数
