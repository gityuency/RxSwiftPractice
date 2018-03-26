//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import Foundation


/// 自定义一个错误事件  自定义的错误事件需要继承自 Error
enum CustomError: Error {
    case yuencyError
}



/// 自定义事件值是整数的序列

let customOB = Observable<Int>.create { (observer) -> Disposable in

    observer.onNext(10)  // 发送消息

    observer.onNext(20) // 发送消息
    
    //如果在这里发送了错误, 就不会走到下面的 onCompleted
    //observer.onError(CustomError.yuencyError)
    
    observer.onCompleted() // 发送完成
    
    return Disposables.create() // 返回一个 Disposable对象
}


customOB.asObservable().subscribe(onNext: { (inn) in
    
    print("收的到 \(inn)")
    
})

/// 然后在这里自己订阅 上面 创建的事件序列
let bag = DisposeBag()

customOB.subscribe(onNext: { (number) in
    
    print("下一个 \(number)")
    
}, onError: { (error) in
    
    print("发生了错误 \(error)")
    
}, onCompleted: {
    
    print("完成了")
    
}) {
    print("回收了")
    
}.disposed(by: bag)


/// 方便调试的操作符
customOB.debug().subscribe{
    print("这里的逻辑和平常一样")
}







