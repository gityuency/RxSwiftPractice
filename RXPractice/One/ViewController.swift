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
                   "Swift - RxSwift的使用详解6（观察者2： 自定义可绑定属性）",
                   "Swift - RxSwift的使用详解7（Subjects、Variables）",
                   "Swift - RxSwift的使用详解8（变换操作符：buffer、map、flatMap、scan等）",
                   "Swift - RxSwift的使用详解9（过滤操作符：filter、take、skip等）",
                   "Swift - RxSwift的使用详解10（条件和布尔操作符：amb、takeWhile、skipWhile等）",
                   "Swift - RxSwift的使用详解11（结合操作符：startWith、merge、zip等）",
                   ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        /* 让表格滚动到底部 */
        let secon = 0 //最后一个分组的索引（0开始，如果没有分组则为0）
        let rows = myArray.count - 1 //最后一个分组最后一条项目的索引
        let indexPath = IndexPath(row: rows, section: secon)
        tableview.scrollToRow(at: indexPath, at:.bottom, animated: true)
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
        } else if indexPath.row == 4 {
            vc = Vc_6_In_One()
        } else if indexPath.row == 5 {
            vc = Vc_7_In_One()
        } else if indexPath.row == 6 {
            vc = Vc_8_In_One()
        } else if indexPath.row == 7 {
            vc = Vc_9_In_One()
        } else if indexPath.row == 8 {
            vc = Vc_10_In_One()
        } else if indexPath.row == 9 {
            vc = Vc_11_In_One()
        }
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
