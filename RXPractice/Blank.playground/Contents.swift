//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import Foundation

/*
 let stringArray = ["1", "2", "3", "4", "5", "6", ]
 let arr = stringArray.flatMap{ Int($0) }.filter{ $0 % 2 == 0}
 print(arr)
 */

/// 以时间为索引的常量队列
/* 一类用来创建 observer  一类接受 ob 作为参数, 并生成一个新的 ob  */



//MARK: -
/// 这里是创建一个事件队列

Observable.of("1","2","3","4","5","6","7","8","9")

/// 这里写的东西只是一些筛选逻辑, 这里的代码并没有执行, 当有人对这个东西感兴趣, 也就存在订阅者的时候, 这个代码才会执行
var eventNumber = Observable.from(["1","2","3","4","5","6","7","8","9"]).map{ Int($0) }.filter{
    if let item = $0, item % 2 == 0 {
//        print("event \(item)")
        return true
    }
    return false
}

/// 这个人是全程关注事件的发生
eventNumber.subscribe { (event) in
//    print("事件 \(event)")
}

/// 这个人是半路关注事件的发生
eventNumber.skip(2).subscribe { (event) in
//    print("半路过来 \(event)")
}




eventNumber.subscribe(onNext: { (event) in
    
//    print("接受 \(event)")
    
}, onError: { (error) in
    
//    print(error)
    
}, onCompleted: {

//    print("任务完成")

}) {
    
//    print("回收了.  在有限的事件序列里面, 在任务完成之后, 就会走到这个回收的方法里面, 但是在无限的事件序列里面, 这样的对象是不会被回收的")
    
}


/// subscribe 的返回值 是 Disposable 对象, 这个对象可以用来取消订阅

/// 我们可以把所有的订阅对象放到一个 bag 里面 当这个 bag 销毁的时候, 里面装的所有的订阅对象都都会取消订阅 订阅资源都会被回收掉

let bag = DisposeBag()

let object = Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe{
    print("订阅到的事件 \($0)")
}.disposed(by: bag)  // 把订阅对象装到要回收的袋子里


//object.dispose()

//dispatchMain() 加上这一句就自动调用了计时器, 这个代码就会自动刷新




