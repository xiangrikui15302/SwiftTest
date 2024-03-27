//
//  Sort.swift
//  SwiftTest
//
//  Created by 张延杰 on 2024/1/15.
//  Copyright © 2024 leeco. All rights reserved.
//

// 共7题
import Foundation

// 1. 冒泡排序
// 每次比较相邻的两个
func sortArray(_ nums: [Int]) -> [Int] {
    var num = nums
    for i in 0..<num.count-1 {
        for j in 0..<num.count-1-i {
            if(num[j]>num[j+1]){
                num.swapAt(j, j+1)
            }
        }
    }
    return num
}

// 2. 选择排序
// 首先，找到数组中最小的那个元素，其次，将它和数组的第一个元素交换位置(如果第一个元素就是最小元素那么它就和自己交换)。其次，在剩下的元素中找到最小的元素，将它与数组的第二个元素交换位置。如此往复
func selectSortArray(_ nums: [Int]) -> [Int] {
    var num = nums
    for i in 0..<num.count - 1 {
        var maxIndex = i
        for j in i+1..<num.count-1 {
            if(num[j]>num[maxIndex]) {
                maxIndex = j
            }
        }
        num.swapAt(i, maxIndex)
    }
    return num
    
}

// 3. 插入排序
// 从第一个元素开始，该元素可以认为已经被排序；
// 取出下一个元素，在已经排序的元素序列中从后向前扫描；
// 如果该元素（已排序）大于新元素，将该元素移到下一位置
// 重复步骤3，直到找到已排序的元素小于或者等于新元素的位置；
func insertSortArray(_ nums: inout [Int]) -> [Int] {
    var num = nums
    
    // 从第二个元素开始
    for startIndex in 1..<num.count {
        let current = num[startIndex]
        for j in (0..<startIndex).reversed() {
            if(current < num[j]) {
                num.swapAt(j, j+1)
            }
        }
    }
    
    return num
}

// 4.快速排序
func quickSortArray(_ arr: inout[Int]) -> [Int] {
    
    quickSort(arr: &arr, left: 0, right: arr.count - 1)
    return arr
}

//快速排序
func quickSort(arr:inout[Int], left:Int, right:Int) {
    
    /*终止条件，如果左边界下标等于右边界下标，或者大于右边界下标的时候，说明当前数组的长度已经是1乃至该数组物理上不存在了，
     因此就直接返回，终止递归，这里是递归出口。
    */
    if(left >= right) {return}
    var l = left
    var r = right
    let base = arr[l];//根据传入的左右边界声明出两个游标，同时指定好基准数，我们命名为base
    while(l <= r) {//只要左右游标不相等，说明二者没有相遇，循环就会继续执行
        /*r游标先行，只要r游标指向的数值大于基准数，r游标就开始游移，
         需要注意的是在j游标游移的过程中也会时刻注意到l和r游标是否相遇了，只要相遇就停止
         */
        while(l<r && arr[r] >= base) {
            r = r - 1 //r游标是往前走
        }
        /*
         l游标后走，只要是l游标指向的数值小于基准数，l游标就开始游移，需要注意的是l游标在游移的过程中也会时刻注意到i和j游标是否相遇了，只要相遇就停止
         */
        while(l<r && arr[l] <= base) {
            l = l + 1
        }
        /*
         在退出上边的外循环之后，说明二者均指向了需要被交换的元素，也就是说l指向了一个大于基准数的元素，
         r指向了一个小于基准数的元素，因此二者发生交换。如果此时两数不是因为这种指向情况而导致的交换，
         是由于相遇导致的交换，那么这个交换将没有意义
         */
        arr.swapAt(l, r)

    }
    arr.swapAt(left, l)//与基准数交换，此时我们已经找到了基准数的准确位置，我们将基准数与当前位置上的元素进行一次交换

    quickSort(arr: &arr, left: left, right: l-1);//递归的处理当前两个游标位置的右边无序数组
    quickSort(arr: &arr, left: l+1,right: right);//递归的处理当前两个游标位置的左边无序数组
    
}

// 5. 最小的k个数（小顶堆实现x）
func smallestK(_ nums: [Int], _ k: Int) -> [Int] {
    var result = [Int]()
    guard nums.count > 0,k>0 else {
        return result
    }
    // 1.先在数组中放入k个数
    for i in 0..<k {
        result.append(nums[i])
    }
    
    // 2. 将这k个数构造出最大堆，自下而上的下滤，从最后一个非叶子节点开始    叶子节点的数量就是result.count/2
    for i in (0..<(result.count/2)).reversed() {
        shiftDown(&result, i)
    }
    // 3. 将剩下的数不断的构造最大堆
    for i in k..<nums.count {
        if result[0] > nums[i] {
            result[0] = nums[i]
            shiftDown(&result, 0)
        }
    }
    return result
    
}

// 堆自下而上的下滤
func shiftDown(_ nums:inout [Int],_ index:Int) {
    let half = nums.count/2
    var index = index
    while index>half {
        let leftchild = 2*index+1
        let rightchild = leftchild+1
        var child = leftchild
        if rightchild<nums.count {
            if nums[rightchild]>nums[leftchild] {
                child = rightchild
            }
        }
        if nums[child]>nums[index] {
            nums.swapAt(child, index)
        } else {
            return
        }
        index = child
    }
}

// 6.前K个高频单词
func topKFrequent(_ words:[String], _ k:Int) -> [String] {
    
    var result = [String]()
    var dict = [String:Int]()
    for word in words {
        if dict[word] == nil {
            dict[word] = 1
        } else {
            dict[word]! += 1
        }
    }
    
    // 对字典按照value的大小排序
    let b = dict.sorted { (dict1, dict2) -> Bool in
        if(dict1.value != dict2.value) {
            return dict1.value > dict2.value
        } else {
            return dict1.key < dict2.key
        }
    }
    
    for (key,_) in b {
        result.append(key)
        if(result.count == k) {
            return result
        }
    }
    
    return result
}

// 7. 滑动窗口最大值
func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    var resultArr = [Int]()
    if nums.count == 0 {return resultArr}
    
    // 1. 双端队列 做滑动窗口，用来存储可能成为最大值的数
    var queue = [Int]()
    // 2. for循环遍历整个数组，往滑动窗口中添加
    for index in 0..<nums.count {
        // 2.1 数组的第一个默认添加进滑动窗口
        if queue.count == 0 {
            queue.append(nums[index])
        } else {
            // 2.2 从数组的第二个起，每次判断num是否比滑动窗口的最后数大，如果大的话就将之前的都移除，直到滑动窗口的大小为0，再将这个数添加进滑动窗口
            while queue.count > 0 && nums[index] > queue.last! {
                _ = queue.popLast()
            }
            
            queue.append(nums[index])
        }
        // 2.3 只要当前index比k-1大，就将滑动窗口中的最大值（即第一个）添加到返回结果中
        if index > k-1 {
            resultArr.append(queue.first!)
        }
        // 2.4 添加完了要注意 如果滑动窗口的大小等于k,就将第一个移除
        if queue.count == k {
            queue.removeFirst()
        }
    }
    
    return resultArr
}

