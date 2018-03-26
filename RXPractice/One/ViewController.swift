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
    
    @IBOutlet var tableview: UITableView!
    
    
    let myArray = ["示例代码, 简单实用表格 使用 RxSwift 进行改造（响应式编程）",
                   "Observable介绍、创建可观察序列",
                   "Observable订阅、事件监听、订阅销毁",
                   "Swift - RxSwift的使用详解5（观察者1： AnyObserver、Binder）",
                   ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCellID")
        cell.textLabel?.text = myArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "我们忽略这些细节"
        cell.imageView?.image = UIImage(named: "a01.jpg")
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vc = UIViewController()
        
        if indexPath.row == 0 {
            vc = Vc_TV_In_One()
        } else if indexPath.row == 1 {
            vc = Vc_2_In_One()
        } else if indexPath.row == 2 {
            vc = Vc_3_In_One()
        } else if indexPath.row == 3 {
            vc = Vc_5_In_One()
        }
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
