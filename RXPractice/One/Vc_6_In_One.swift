//
//  Vc_6_In_One.swift
//  RXPractice
//
//  Created by yuency on 26/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Vc_6_In_One: UIViewController {
    
    
    @IBOutlet var label: UILabel!
    let disposeBag = DisposeBag()
    
    /*
     五、自定义可绑定属性
     有时我们想让 UI 控件创建出来后默认就有一些观察者，而不必每次都为它们单独去创建观察者。比如我们想要让所有的 UIlabel 都有个 fontSize 可绑定属性，它会根据事件值自动改变标签的字体大小。
     */
    func usage_1() {
        
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance) //每隔 0.5秒 数数, 1 ,2,3,4,5,6,7,8,9......
        observable
            .map {
                let k = CGFloat($0)
                print(k)
                return k
            } //把每次穿过来数据 换成 cgfloat
            .bind(to: label.fontSize) //根据索引数不断变放大字体  // 这个 bind 方法就是 订阅, 理解为 subscribe 方法, 需要传递一个 可以观察的对象
            .disposed(by: disposeBag)
    }
    
    
    /*
     方式二：通过对 Reactive 类进行扩展
     既然使用了 RxSwift，那么更规范的写法应该是对 Reactive 进行扩展。这里同样是给 UILabel 增加了一个 fontSize 可绑定属性。
     （注意：这种方式下，我们绑定属性时要写成 label.rx.fontSize）
     */
    func usage_2() {
        
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable
            .map { CGFloat($0) }
            .bind(to: label.rx.fontSize) //根据索引数不断变放大字体
            .disposed(by: disposeBag)
    }
    
    
    
    /*
     六、RxSwift 自带的可绑定属性（UI 观察者）
     （1）其实 RxSwift 已经为我们提供许多常用的可绑定属性。比如 UILabel 就有 text 和 attributedText 这两个可绑定属性。
     */
    
    func usage_3() {
        
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable
            .map { String("使用 Rx 自带的 \($0)") }
            .bind(to: label.rx.text) //  Rx自带提供的东西.
            .disposed(by: disposeBag)
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usage_3()
        
    }
}


extension UILabel {
    
    /// 因为这个 Binder 就是继承自 ObserverType 协议的, 也就是一个 OB
    public var fontSize: Binder<CGFloat> {
        
        // 在这里使用 Binder 的构造方法创建出这个 bind 对象
        return Binder(self, binding: { (myLabel, mysize) in
            myLabel.font = UIFont.systemFont(ofSize: mysize)
            //self.font = UIFont.systemFont(ofSize: mysize)
        })
    }
}


extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}


