//
//  TreeNode.swift
//  SwiftTest
//
//  Created by leeco on 2023/1/3.
//  Copyright © 2023年 leeco. All rights reserved.
//
// 共10题

import Foundation
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

var result = [Int]();
// 1. 二叉树的中序遍历   左   父   右
func inorderTraversal(_ root: TreeNode?)-> [Int] {
    if let root = root {
        _ = inorderTraversal(root.left)
        result.append(root.val)
        _ = inorderTraversal(root.right)
    }
    return result
}

// 2. 二叉树的前序遍历   父   左   右
func preorderTraversal(_ root: TreeNode?)-> [Int] {
    guard let root = root else {
        return result
    }
    result.append(root.val)
    _ = preorderTraversal(root.left)
    _ = preorderTraversal(root.right)
    return result
}

//  二叉树的后序遍历     左   右   父
func postorderTraversal(_ root: TreeNode?) -> [Int] {
    
    if let root = root {
        _ = postorderTraversal(root.left)
        _ = postorderTraversal(root.right)
        result.append(root.val)
    }
    
    return result

}

// 3. 二叉树翻转
func invertTree(_ root: TreeNode?) -> TreeNode? {
    guard let root = root else {
        return nil
    }
    if(root.left == nil && root.right == nil) {
        return root
    }
    let temp = root.left
    root.left = root.right
    root.right = temp
    
    _ = invertTree(root.left)
    _ = invertTree(root.right)
    return root
}

// 4. 二叉树的层序遍历
func levelOrder(_ root: TreeNode?) -> [[Int]] {
    
    var res = [[Int]]()
    guard let root = root else {
        return res
    }
    // 用一个队列来存储所有的节点
    var queue = [root]
    while queue.count != 0 {
        var level = [Int]()
        for _ in queue {
            let node = queue.removeFirst()
            level.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
            
        }
        res.append(level)
    }
    
    return res
}

// 5. 从前序遍历和中序遍历构造二叉树
// 前序的第一个就是root
func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
    
    if (preorder.count == 0 || inorder.count == 0) {
        return nil
    }
    
    let root = TreeNode(preorder[0])
    var middelIndex = 0
    for i in 0..<inorder.count {
        if inorder[i] == root.val {
            middelIndex = i
            break
        }
    }
    
    let leftInorder = Array(inorder[..<middelIndex])
    let rightInorder = Array(inorder[middelIndex+1..<inorder.endIndex])
    
    let leftPreorder = Array(preorder[1..<leftInorder.count+1])
    let rightPreorder = Array(preorder[leftInorder.count+1..<preorder.count])
    
    root.left = buildTree(leftPreorder, leftInorder)
    root.right = buildTree(rightPreorder, leftInorder)
    return root
}

// 6. 二叉树的最大深度
func maxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else {
        return 0
    }
    let leftHeight = maxDepth(root.left)
    let rightHeight = maxDepth(root.right)
    
    return max(leftHeight, rightHeight) + 1
}


// 7. 二叉搜索树的最近公共祖先
// 二叉搜索树：如果左子树不为空那么左子树就小于父节点的值，如果右子树不为空，那么右子树就大于父节点的值
// 如果 p q 值 都小于 根结点，那么我们去左子树寻找
// 如果 p q 值 都大于 根结点，那么我们去右子树寻找
// 其他情况，我们就可以说，p q 分别在当前根结点的左右，于是 当前根结点就是 最近公共祖先
func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    if root == nil {return root}
    
    // 递归
//    if root!.val > p!.val && root!.val > q!.val {
//        return lowestCommonAncestor(root!.left,p,q)
//    } else if root!.val < p!.val && root!.val < q!.val {
//        return lowestCommonAncestor(root!.right,p,q)
//    } else {
//        return root
//    }
    // 迭代
    var root = root
    while root != nil {
        if root!.val > p!.val && root!.val > q!.val {
            root = root?.left
        } else if root!.val < p!.val && root!.val < q!.val {
            root = root?.right
        } else {
            return root
        }
    }
    return root
   
}

// 两棵树相等
func DoesTreeHaveTree2(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
    if B == nil {
        return true
    }
    if A == nil {
        return false
    }
    if A!.val != B!.val {
        return false
    }
    return DoesTreeHaveTree2(A!.left,B!.left) && DoesTreeHaveTree2(A!.right,B!.right)
}

// 8. B树是否是A的子树
func isSubStructure(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
    if A == nil || B == nil {
        return false
    }
    if DoesTreeHaveTree2(A,B){
        return true
    }
    if isSubStructure(A!.left,B) {
        return true
    }
    if isSubStructure(A!.right,B) {
        return true
    }
    return false
}
