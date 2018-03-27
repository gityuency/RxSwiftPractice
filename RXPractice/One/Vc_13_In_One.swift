//
//  Vc_13_In_One.swift
//  RXPractice
//
//  Created by yuency on 26/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit


/*
 十三、连接操作（Connectable Observable Operators）
 1，可连接的序列
 可连接的序列（Connectable Observable）：
 （1）可连接的序列和一般序列不同在于：有订阅时不会立刻开始发送事件消息，只有当调用 connect() 之后才会开始发送值。
 （2）可连接的序列可以让所有的订阅者订阅后，才开始发出事件消息，从而保证我们想要的所有订阅者都能接收到事件消息。
 */
class Vc_13_In_One: UIViewController {

    
    func usage_1() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
