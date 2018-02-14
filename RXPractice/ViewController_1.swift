//
//  ViewController_1.swift
//  RXPractice
//
//  Created by yuency on 13/02/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


// 表示我们的一些请求的结果
enum Result {
    case ok(message: String)
    case empty
    case failed(message: String)
}


class ViewController_1: UIViewController {

    @IBOutlet var userNameTF: UITextField!
    
    @IBOutlet var usernamelabel: UILabel!

    

    
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        let viewModel = RegisterViewModel()
        
        userNameTF.rx.text.orEmpty.bind(to: viewModel.username).disposed(by: disposeBag)
        

        
    }
    
    
    
}
