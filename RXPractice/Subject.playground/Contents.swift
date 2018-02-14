//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import Foundation


/// 创建一个 subject 泛型约束他可以 发布的 订阅的 事件类型
let subject = PublishSubject<String>()

/// 这个东西收到的事件会向前推一个, 也就是会收到订阅位置之前的 一个 消息
//let subject = BehaviorSubject<String>(value: "给订阅者默认发送的事件内容")

/// 这个东西带有缓冲区 会发送订阅时刻之前 指定个数的 消息 如果订阅之前没有消息发送, 那么就没有消息
//let subject = ReplaySubject<String>.create(bufferSize: 2)



let sub1 = subject.subscribe(onNext: { (mesage) in
    print("收音机 1  \(mesage)")
})


/// 需要注意发送消息的时机和订阅消息的时机, 在消息 A 发送之前订阅消息, 就可以收到 A 消息和以后 发送的消息, 在 A 消息发送之后订阅 A 消息, 是收不到 A 和 A 之前的消息的
subject.onNext("发送了一条消息 A")

sub1.dispose() //取消了订阅 , 将不再收到任何消息


//// OB 这种东西, 在取消订阅会导致他被回收掉, 资源结束, 或者发生错误, 也会导致OB 被取消订阅, 被回收


let sub2 = subject.subscribe(onNext: { (mesage) in
    print("第二个收音机: \(mesage)")
})


subject.onNext("发送了一条消息 B ")
subject.onNext("发送了一条消息 C")


sub2.dispose()




/// 还有一个特殊的 subject
/*  这个东西 没有 onError 事件!  也不能手动加上 onCompleted 事件, */
let stringVariable = Variable("这是自定义的 Subject")

let customSub = stringVariable.asObservable().subscribe{
    print("收到了 \($0)")
}

//可以赋值
stringVariable.value = "重新赋值"  //这其实就是一个 onNext 事件, 在这个事件之后, 就会自动调用 onCompleted 事件
//直接就能拿到值
print("\(stringVariable.value)")










