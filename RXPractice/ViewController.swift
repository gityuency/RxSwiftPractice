//
//  ViewController.swift
//  RXPractice
//
//  Created by yuency on 13/02/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self .button_1(UIButton())
        
    }
    
    
    
    @IBAction func button_1(_ sender: UIButton) {
        
        let vc = ViewController_1()
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
}

