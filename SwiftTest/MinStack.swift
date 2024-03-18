//
//  SwiftTest
//
//  Created by leeco on 2022/12/26.
//  Copyright © 2022年 leeco. All rights reserved.
//

// 共1题
import Foundation
class MinStack {
    var stack1:[Int] = []
    var stack2:[Int] = []
    /** initialize your data structure here. */
    init() {
        stack1 = [Int]()
        stack2 = [Int]()
    }
    
    func push(_ x: Int) {
        stack1.append(x)
        if(stack2.count == 0) {
            stack2.append(x)
        } else {
            stack2.append(Swift.min(stack2.last!,x))
        }
        
    }
    
    func pop() {
        _ = stack1.popLast()
        _ = stack2.popLast()
    }
    
    func top() -> Int {
        if stack1.count > 0 {
            return stack1.last!
        }
        return 0
    }
    
    func min() -> Int {
        return stack2.last!
    }
}




