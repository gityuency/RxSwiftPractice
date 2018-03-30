//
//  Vc_22_In_Two.swift
//  RXPractice
//
//  Created by yuency on 27/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
/*
 Swift - RxSwift的使用详解22（UI控件扩展2：UITextField、UITextView）
 
 */
class Vc_22_In_Two: UIViewController {
    
    
    /*
     1，监听单个 textField 内容的变化（textView 同理）
     （1）下面样例中我们将 textField 里输入的内容实时地显示到控制台中。
     */
    func usage_1() {
        
        //创建文本输入框
        let textField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        textField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(textField)
        
        //当文本框内容改变时，将内容输出到控制台上
        textField.rx.text.orEmpty.asObservable()  //注意：.orEmpty 可以将 String? 类型的 ControlProperty 转成 String，省得我们再去解包。
            .subscribe(onNext: {
                print("您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
        
        
        //（3）当然我们直接使用 change 事件效果也是一样的。
        textField.rx.text.orEmpty.changed
            .subscribe(onNext: {
                print("您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
    }
    
    
    
    /*
     2，将内容绑定到其他控件上
     （1）效果图
     我们将第一个 textField 里输入的内容实时地显示到第二个 textField 中。
     同时 label 中还会实时显示当前的字数。
     最下方的“提交”按钮会根据当前的字数决定是否可用（字数超过 5 个字才可用）
     
     （2）样例代码
     Throttling 的作用：
     Throttling 是 RxSwift 的一个特性。因为有时当一些东西改变时，通常会做大量的逻辑操作。而使用 Throttling 特性，不会产生大量的逻辑操作，而是以一个小的合理的幅度去执行。比如做一些实时搜索功能时，这个特性很有用。
     */
    func usage_2() {
        
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        inputField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(inputField)
        
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        outputField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(outputField)
        
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:190, width:300, height:30))
        self.view.addSubview(label)
        
        //创建按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:230, width:100, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
        
        //当文本框内容改变
        let input = inputField.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
            .throttle(0.3) //在主线程中操作，0.3秒内值若多次改变，取最后一次
        
        //内容绑定到另一个输入框中
        input.drive(outputField.rx.text)
            .disposed(by: disposeBag)
        
        //内容绑定到文本标签中
        input.map{ "当前字数：\($0.count)" }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        //根据内容字数决定按钮是否可用
        input.map{ $0.count > 5 }
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
    
    
    /*
     3，同时监听多个 textField 内容的变化（textView 同理）
     （1）效果图
     界面上有两个输入框分别用于填写电话的区号和号码。
     无论那一个输入框内容发生变化，都会将它们拼成完整的号码并显示在 label 中。
     */
    func usage_3() {
    
        
    }
    
    
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        usage_3()
        
    }
    
    
}
