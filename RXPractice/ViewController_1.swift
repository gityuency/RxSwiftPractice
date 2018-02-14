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
    
    deinit {
        print("控制器已经销毁")
    }
    
    @IBOutlet var userNameTF: UITextField!
    
    @IBOutlet var usernamelabel: UILabel!
    
    
    
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = RegisterViewModel()
        
        userNameTF.rx.text.orEmpty.bind(to: viewModel.username).disposed(by: disposeBag)
        
        
        
    
        let a = UITableViewController()
        
        let b = UIAlertController()
        
        let c = UIViewController()
        
        dataArray.value = [a, b, c]
        
        dataArray.asObservable().subscribe { (array) in
            print(" ******  \(array)   ")
            }.disposed(by: bag)
        
        
        
    }
    
    
    
    
    /// 这样是初始化了一个东西....
    var dataArray = Variable<[UIViewController]>([])
    var bag = DisposeBag()
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        print("开始更改")
        
//        let vc = dataArray.value[0]
//        vc.title = "fdsafdsafdasfdas"
        
        let vc = UIInputViewController()
        
        dataArray.value[1] = vc
        
        
    }
    
}
