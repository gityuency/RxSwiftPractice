//
//  Vc_2_In_One.swift
//  RXPractice
//
//  Created by yuency on 26/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//


/*
 Observable<T>
 Observable<T> 这个类就是 Rx 框架的基础，我们可以称它为可观察序列。它的作用就是可以异步地产生一系列的 Event（事件），即一个 Observable<T> 对象会随着时间推移不定期地发出 event(element : T) 这样一个东西。
 而且这些 Event 还可以携带数据，它的泛型 <T> 就是用来指定这个 Event 携带的数据的类型。
 有了可观察序列，我们还需要有一个 Observer（订阅者）来订阅它，这样这个订阅者才能收到 Observable<T> 不时发出的 Event。
 
 可以看到 Event 就是一个枚举，也就是说一个 Observable 是可以发出 3 种不同类型的 Event 事件：
 
 next：next 事件就是那个可以携带数据 <T> 的事件，可以说它就是一个“最正常”的事件。
 error：error 事件表示一个错误，它可以携带具体的错误内容，一旦 Observable 发出了 error event，则这个 Observable 就等于终止了，以后它再也不会发出 event 事件了。
 completed：completed 事件表示 Observable 发出的事件正常地结束了，跟 error 一样，一旦 Observable 发出了 completed event，则这个 Observable 就等于终止了，以后它再也不会发出 event 事件了。
 
 Observable 与 Sequence比较
 （1）为更好地理解，我们可以把每一个 Observable 的实例想象成于一个 Swift 中的 Sequence：
 即一个 Observable（ObservableType）相当于一个序列 Sequence（SequenceType）。
 ObservableType.subscribe(_:) 方法其实就相当于 SequenceType.generate()
 
 （2）但它们之间还是有许多区别的：
 Swift 中的 SequenceType 是同步的循环，而 Observable 是异步的。
 Observable 对象会在有任何 Event 时候，自动将 Event 作为一个参数通过 ObservableType.subscribe(_:) 发出，并不需要使用 next 方法。
 
 */

import UIKit
import RxSwift

class Vc_2_In_One: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //四、创建 Observable 序列
        
        OB_13()
        
        
    }
    
    /*
     1，just() 方法
     （1）该方法通过传入一个默认值来初始化。
     （2）下面样例我们显式地标注出了 observable 的类型为 Observable<Int>，即指定了这个 Observable 所发出的事件携带的数据类型必须是 Int 类型的。
     */
    func OB_1() {
        let observable = Observable<Int>.just(5)
        let ob = Observable.just(2)
    }
    
    
    /*
     2，of() 方法
     （1）该方法可以接受可变数量的参数（必需要是同类型的）
     （2）下面样例中我没有显式地声明出 Observable 的泛型类型，Swift 也会自动推断类型。
     */
    func OB_2() {
        let observable = Observable.of("A","B","C")
    }
    
    /*
     3，from() 方法
     （1）该方法需要一个数组参数。
     （2）下面样例中数据里的元素就会被当做这个 Observable 所发出 event 携带的数据内容，最终效果同上面饿 of() 样例是一样的。
     */
    func OB_3() {
        let observable = Observable.from(["A","B","C"])
    }
    
    /*
     4，empty() 方法
     该方法创建一个空内容的 Observable 序列。
     同样需要指定类型,是什么类型的 空 序列
     */
    func OB_4() {
        let observable = Observable<Any>.empty()
    }
    
    /*
     5，never() 方法
     该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
     */
    func OB_5() {
        let observable = Observable<Int>.never()
    }
    
    /*
     6，error() 方法
     该方法创建一个不做任何操作，而是直接发送一个错误的 Observable 序列。
     */
    func OB_6() {
        enum MyError: Error {
            case A
            case B
        }
        
        let observable = Observable<Int>.error(MyError.A)
    }
    
    /*
     7，range() 方法
     （1）该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的 Observable 序列。
     （2）下面样例中，两种方法创建的 Observable 序列都是一样的。
     */
    func OB_7() {
        //使用range()
        let observable1 = Observable.range(start: 1, count: 5)
        
        //使用of()
        let observable2 = Observable.of(1, 2, 3 ,4 ,5)
    }
    
    /*
     8，repeatElement() 方法
     该方法创建一个可以无限发出给定元素的 Event 的 Observable 序列（永不终止）。
     1
     */
    func OB_8() {
        let observable = Observable.repeatElement(1)
    }
    
    /*
     9，generate() 方法
     （1）该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列。
     （2）下面样例中，两种方法创建的 Observable 序列都是一样的。
     */
    func OB_9() {
        //使用generate()方法
        let observable1 = Observable.generate(
            initialState: 0,
            condition: { $0 <= 10 },
            iterate: { $0 + 2 }
        )
        
        let myOB = Observable.generate(initialState: 0, condition: { (k) -> Bool in
            k > 1
        }) { (a) -> Int in
            a + 1
        }
        
        //使用of()方法
        let observable2 = Observable.of(0 , 2 ,4 ,6 ,8 ,10)
    }
    
    
    /*
     10，create() 方法
     （1）该方法接受一个 block 形式的参数，任务是对每一个过来的订阅进行处理。
     （2）下面是一个简单的样例。为方便演示，这里增加了订阅相关代码（关于订阅我之后会详细介绍的）。
     */
    func OB_10() {
        
        //这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        //当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
        let observable = Observable<String>.create{observer in
            //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
            observer.onNext("hangge.com")
            //对订阅者发出了.completed事件
            observer.onCompleted()
            //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create()
        }
        
        //订阅测试
        observable.subscribe {
            print($0)
        }
        
        //自己的 OB
        let myOb = Observable<String>.create { (bkbbkbk) -> Disposable in
            bkbbkbk.onNext("wo")
            bkbbkbk.onCompleted()
            return Disposables.create()
        }
        myOb.subscribe { (string) in
            print(string)
        }
    }
    
    /*
     11，deferred() 方法
     （1）该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable 序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方。
     */
    func OB_11() {
        
        //用于标记是奇数、还是偶数
        var isOdd = true
        
        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        let factory : Observable<Int> = Observable.deferred {
            
            //让每次执行这个block时候都会让奇、偶数进行交替
            isOdd = !isOdd
            
            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            // 创建出来的东西是 Int 序列, 所以 每一次的 onNext 都打印出一个 值, 每一 次订阅都会打印4次 next 和 一次 complete
            if isOdd {
                return Observable.of(1, 3, 5 ,7)
            }else {
                return Observable.of(2, 4, 6, 8)
            }
        }
        
        //第1次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
        
        //第2次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
        
    }
    
    /*
     12，interval() 方法
     （1）这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去。
     （2）下面方法让其每 1 秒发送一次，并且是在主线程（MainScheduler）发送。
     
    !!!  注意了, 在视图控制器销毁的时候这个东西并不会终止   也就是个定时器
     */
    func OB_12() {
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.subscribe { event in
            print(event)
        }
    }
    
    
    /*
     13，timer() 方法
     （1）这个方法有两种用法，一种是创建的 Observable 序列在经过设定的一段时间后，产生唯一的一个元素。
     延时类一次性定时器
     */
    func OB_13() {
        //5秒种后发出唯一的一个元素0
        let observable1 = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        observable1.subscribe { event in
            print(event)
        }
        
        //（2）另一种是创建的 Observable 序列在经过设定的一段时间后，每隔一段时间产生一个元素。
        //延时5秒种后，每隔1秒钟发出一个元素
        let observable2 = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
        observable2.subscribe { event in
            print(event)
        }
    }
    
    
    deinit {
        print("销毁 Vc_2_In_One ...")
    }
    
}
