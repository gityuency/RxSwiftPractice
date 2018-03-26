//
//  Vc_12_In_One.swift
//  RXPractice
//
//  Created by yuency on 26/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxSwift

/*
 十二、算数、以及聚合操作（Mathematical and Aggregate Operators）
 */

class Vc_12_In_One: UIViewController {
    
    /*
     1，toArray
     （1）基本介绍
     该操作符先把一个序列转成一个数组，并作为一个单一的事件发送，然后结束。
     */
    func usage_1()  {
        
        Observable.of(1, 2, 3)
            .toArray()
            .subscribe(onNext: { print($0) })  //得到的是数组
            .disposed(by: disposeBag)
    }
    
    
    
    /*
     2，reduce
     （1）基本介绍
     reduce 接受一个初始值，和一个操作符号。
     reduce 将给定的初始值，与序列里的每个值进行累计运算。得到一个最终结果，并将其作为单个值发送出去。
     
     */
    func usage_2()  {
        
        Observable.of(1, 2, 3, 4, 5)
            .reduce(0, accumulator: +)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    /*
     3，concat
     （1）基本介绍
     concat 会把多个 Observable 序列合并（串联）为一个 Observable 序列。
     并且只有当前面一个 Observable 序列发出了 completed 事件，才会开始发送下一个 Observable 序列事件。

     */
    func usage_3() {
     
        let subject1 = BehaviorSubject(value: 1)
        let subject2 = BehaviorSubject(value: 2)
        
        let variable = Variable(subject1)
        variable.asObservable()
            .concat()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject2.onNext(2)
        subject1.onNext(1)
        subject1.onNext(1)
        subject1.onCompleted()
        
        variable.value = subject2
        subject2.onNext(2)
        
    }
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usage_3()
    }
}
