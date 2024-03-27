//
//  LinkList.swift
//  SwiftTest
//
//  Created by 回旋工作者 on 2023/8/31.
//  Copyright © 2023 leeco. All rights reserved.
//

// 共9题
import Foundation

public class LinkList {
    public var val: Int
    public var next: LinkList?
    public init(_ val: Int = 0) {
        self.val = val
        self.next = nil
    }
}

// 1. 返回链表的中心节点   1,2,3,4,5,6
// 快慢指针，慢指针走一步，快指针走两步
func getMiddleNode(_ linkList: LinkList?) -> LinkList?{
    
    if(linkList == nil || linkList!.next == nil) {
        return linkList
    }
    
    var slowNode = linkList
    var fastNode = linkList
    
    while fastNode != nil  && fastNode?.next != nil {
        slowNode = slowNode?.next
        fastNode = fastNode?.next?.next
        
    }
    
    return slowNode
}

// 2.删除链表的倒数第k个
func removeNthFromEnd(_ head: LinkList?, _ n: Int) -> LinkList? {
    
    let tempHead = LinkList.init()
    tempHead.next = head

    var fast = head
    var slow:LinkList? = tempHead

    var count = 0
    while fast != nil {

        if count >= n {
          slow = slow?.next
        }
        count += 1
        fast = fast?.next
    }

    slow?.next = slow?.next?.next

    return tempHead.next

}

// 3.从尾到头打印链表
func printListFromTailToHead(_ linkList:LinkList) -> [Int] {
   
    var linkNode:LinkList?
    linkNode = linkList
    var result = [Int]()
    while linkNode != nil {
        result.append(linkNode!.val)
        linkNode = linkNode!.next
    }
    
    return result.reversed()
}

// 4.链表反转
func ReverseList ( _ head: LinkList?) -> LinkList? {
    guard let head = head else {return nil}
    var resultList:LinkList? = nil
    var tempNode = head
    var currentNode = head
    while(currentNode.next != nil) {
        tempNode = currentNode.next!
        currentNode.next = resultList
        resultList = currentNode
        currentNode = tempNode
        
    }
    return resultList
}

// 5.两个链表的第一个公共点
func findFirstCommonNode(_ pHead1:LinkList?,_ pHead2:LinkList?) -> LinkList? {
    if pHead1 == nil || pHead2 == nil {
        return nil
    }
    var A = pHead1
    var B = pHead2
    while A !== B {
        if (A?.next == nil) {
            A = pHead2
        } else {
            A = A?.next
        }
        
        if (B?.next == nil) {
            B = pHead1
        } else {
            B = B?.next
        }
    }
    return A
}

// 链表是否有环，并返回相遇的节点
func meetingNode(_ pHead:LinkList?) -> LinkList?{
    if let pHead = pHead {
        var quickNode:LinkList? = pHead
        var slowNode:LinkList? = pHead
        while quickNode?.next != nil {
            slowNode = slowNode?.next
            quickNode = quickNode?.next?.next
            if(slowNode === quickNode) {
                return slowNode
            }
        }
    }
    
    return nil
}

// 6.链表中环的入口节点
func entryNodeOfLoop(_ pHead:LinkList?) -> LinkList?{
    if(pHead == nil || pHead?.next == nil) {
        return nil
    }
    var meetingNode = meetingNode(pHead)
    // 没有环
    if meetingNode == nil {
        return nil
    }
    // 求环的长度
    let temp = meetingNode
    var circleLength = 1
    meetingNode = meetingNode?.next
    while temp !== meetingNode {
        meetingNode = meetingNode?.next
        circleLength += 1
    }
    
    var slowNode = pHead
    var quickNode = pHead
    //快指针先走len步
    for _ in 0..<circleLength {
        quickNode = quickNode?.next
    }
    // 快慢指针相交即为环的入口
    while slowNode !== quickNode {
        slowNode = slowNode?.next
        quickNode = quickNode?.next
    }
    return slowNode
}
// 7.合并两个有序链表
func mergeTwoLists(_ list1: LinkList?, _ list2: LinkList?) -> LinkList? {
    if list1 == nil{
        return list2
    } else if list2 == nil {
        return list1
    }
    var l1 = list1
    var l2 = list2
//    if l1!.val < l2!.val {
//        l1?.next = mergeTwoLists(l1?.next, l2)
//        return l1
//    } else {
//        l2?.next = mergeTwoLists(l2?.next, l1)
//        return l2
//    }
    var resultLink = LinkList()
    var current = resultLink
    while l1?.next != nil || l2?.next != nil {
        if l1?.val ?? Int.max < l2?.val ?? Int.max{
            current.next = l1
            l1 = l1?.next
        } else {
            current.next = l2
            l2 = l2?.next
        }
        current = current.next!
    }
    
    return resultLink.next
    
}

// 8. 删除排序链表中重复的节点
func deleteDuplicates(head: LinkList?) -> LinkList? {

    if head == nil || head?.next == nil {
        return head
    }
    
    var cur = head
    while cur?.next != nil {
        if cur?.val == cur?.next?.val {
            cur?.next = cur?.next?.next
        } else {
            cur = cur?.next
        }
        
    }
    
    return head
    
}
