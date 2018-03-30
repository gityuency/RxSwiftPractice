//
//  Vc_3_1_In_Thr.swift
//  RXPractice
//
//  Created by yuency on 30/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class Vc_3_1_In_Thr: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var textinput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textinput.rx.text.orEmpty.asObservable()  //这里的东西是通过逐层加工来得到我们想要的数据
            .map({ input -> Int in //这里对输入的东西进行二次加工
                
                if let lastChar = input.last {
                    if let n = Int(String(lastChar)) {
                        return n
                    }
                }
                return -1
            })
            .filter({ number -> Bool in  //这个东西用于逐个过滤数组中的元素, 满足过滤条件的东西将会被过滤出去
                
                 return number % 2 == 0

            })
            .subscribe(onNext: {
                
                print(" 找到最后一个数, 这个数是偶数就 输出 \($0)")
                
                
            }).disposed(by: disposeBag)
        
        
        
    }
    
}
