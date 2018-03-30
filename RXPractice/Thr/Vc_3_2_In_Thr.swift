//
//  Vc_3_2_In_Thr.swift
//  RXPractice
//
//  Created by yuency on 30/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Vc_3_2_In_Thr: UIViewController {
    
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var button: UIButton!
    var interval: Observable<Int>!
    
    var dispose: Disposable!
    
    
    var bag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.interval = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        
        self.dispose = self.interval
            .map{ return String($0) }
            .subscribe(onNext: { sting in
                
                self.label.text = sting
            })
        

        self.dispose.addDisposableTo(bag)  //把对象装进垃圾袋
    
        
        self.button.rx.tap.subscribe(onNext: {
        
            print("按钮点击")
    
            //self.bag = nil  //这个操作是清空垃圾袋 但是这个东西貌似不好用了...
            
        })
        
        
        
    }
    
    
    @IBAction func buttonaction(_ sender: UIButton) {
        
    }
    
}
