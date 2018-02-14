//: Playground - noun: a place where people can play

import UIKit
import RxSwift

///操作符的解释

func example(_ description: String,
             action: () -> Void) {
    
    print("================== \(description) ==================")
    action()
}



///示例代码 1  忽略掉 所有的 next 事件
example("ignoreElements") {
    
    let task = PublishSubject<String>()
    let bag = DisposeBag()
    
    ///
//    task.subscribe{ print($0) }.disposed(by: bag)
    
    /// 忽略掉所有 ignoreElements() 事件
//    task.ignoreElements().subscribe{ print($0) }.disposed(by: bag)
    
    /// 忽略特定个数的事件
//    task.skip(2).subscribe{ print($0) }.disposed(by: bag)

    /// 自定义忽略的条件 "忽略直到..."
    task.skipWhile({ (stirng) -> Bool in
        
        stirng != "T2" //当 string 为 "T2" 的时候,从 T2开始后面的事件都不会被忽略掉
        
    }).subscribe{ print($0) }.disposed(by: bag)
    
    task.onNext("T1")
    
    task.onNext("T2")
    
    task.onNext("T3")
    
    task.onCompleted()
}



example("ignoreElements - skipUntil") {
    
    let tasks = PublishSubject<String>()
    let bossIsAngry = PublishSubject<String>()
    let bag = DisposeBag()
    
    
    /// 直到某个事件开始, 才进行操作
    tasks.skipUntil(bossIsAngry)
        .subscribe {
            print($0)
        }
        .disposed(by: bag)
    
    tasks.onNext("T1");
    tasks.onNext("T2");
    bossIsAngry.onNext("");
    tasks.onNext("T3");
    tasks.onCompleted();
}


example("ignoreElements - distinctUntilChanged") {
    
    let tasks = PublishSubject<String>()
    let bag = DisposeBag()
    
    /// 忽略掉连续重复的事件
    tasks.distinctUntilChanged()
        .subscribe {
            print($0)
        }
        .disposed(by: bag)
    
    tasks.onNext("T1");
    tasks.onNext("T1");
    tasks.onNext("T2");
    tasks.onNext("T2");
    tasks.onNext("T2");
    tasks.onNext("T3");
    tasks.onNext("T3");
    tasks.onCompleted();
}




/// 如何获取到特定的事件
example("获取指定的事件") {
    
    let task = PublishSubject<String>()
    let bag = DisposeBag()
    
    ///
//    task.elementAt(2).subscribe{ print($0) }.disposed(by: bag)
    

    /// 拿到指定序列的事件
//    task.filter{ $0 == "T2"}.subscribe{ print($0) }.disposed(by: bag)

    /// 订阅前两个事件
//    task.take(2).subscribe{ print($0) }.disposed(by: bag)
    
    
    /// 订阅事件直到某个事件
//    task.takeWhile{ $0 != "T3"}.subscribe{ print($0) }.disposed(by: bag)
    
    
    /// 获取事件, 并且获取位置...
    task.enumerated().takeWhile({ (index, string) -> Bool in
        
        index != 2
        
    }).subscribe{
        print($0)
        }.disposed(by: bag)
    
    
    task.onNext("T1")
    
    task.onNext("T2")
    
    task.onNext("T3")

    task.onNext("T4")

    task.onCompleted()
}



example("ignoreElements") {
    let tasks = PublishSubject<String>()
    let bossHasGone = PublishSubject<Void>()
    let bag = DisposeBag()
    
    tasks.takeUntil(bossHasGone).subscribe{print($0)}.disposed(by: bag)
    
    tasks.onNext("T1")
    tasks.onNext("T2")
    tasks.onNext("T3")
    tasks.onCompleted()
}










