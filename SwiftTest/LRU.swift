//
//  LRU.swift
//  SwiftTest
//
//  Created by 张延杰 on 2023/10/30.
//  Copyright © 2023 leeco. All rights reserved.
//

// 共1题
import Foundation
class LRUCache {
    var capacity = 0
    var dict = [Int:MyNode]()
    var linkNode:MyNode?

    init(_ capacity: Int) {
        self.capacity = capacity
        linkNode = MyNode.init()
    }
    
    func get(_ key: Int) -> Int {
        if let node = dict[key] {
            removeNode(node)
            addNodeAtLast(node)
            return node.val
        }
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = dict[key] {
            removeNode(node)
            node.val = value
            addNodeAtLast(node)
        } else {
            if(dict.count == self.capacity) {
                removeFirstNode()
            }
            var newNode = MyNode(value)
            addNodeAtLast(newNode)
            dict[key] = newNode
            
        }
    }
    
    
    func removeNode(_ node : MyNode){
        node.preNode?.nextNode = node.nextNode
        node.nextNode?.preNode = node.preNode
    }
    
    func addNodeAtLast(_ node : MyNode){
        node.preNode = linkNode
        linkNode?.nextNode = node
    }
    
    func removeFirstNode() {
        capacity -= 1
        linkNode = linkNode?.nextNode
    }
}

class MyNode {
    var val:Int
    var preNode:MyNode?
    var nextNode:MyNode?
    init(_ val : Int = 0) {
        self.val = val
    }
    
}
