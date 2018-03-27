//
//  ViewController_2.swift
//  RXPractice
//
//  Created by yuency on 27/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit

class ViewController_2: UIViewController {

    @IBOutlet var tableview: UITableView!
    
    let myArray = ["Swift - RxSwift的使用详解21（UI控件扩展1：UILabel）",
                   
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


extension ViewController_2: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ViewController_2_CELL_ID")
        cell.textLabel?.text = myArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "今天接了个电话"
        cell.imageView?.image = UIImage(named: "a10.jpg")
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vc = UIViewController()
        
        if indexPath.row == 0 {
            vc = Vc_21_In_Two()
        } else if indexPath.row == 1 {
//            vc = Vc_2_In_One()
        } else if indexPath.row == 2 {
//            vc = Vc_3_In_One()
        } else if indexPath.row == 3 {
//            vc = Vc_5_In_One()
        } else if indexPath.row == 4 {
//            vc = Vc_6_In_One()
        } else if indexPath.row == 5 {
//            vc = Vc_7_In_One()
        } else if indexPath.row == 6 {
//            vc = Vc_8_In_One()
        } else if indexPath.row == 7 {
//            vc = Vc_9_In_One()
        } else if indexPath.row == 8 {
//            vc = Vc_10_In_One()
        } else if indexPath.row == 9 {
//            vc = Vc_11_In_One()
        } else if indexPath.row == 10 {
//            vc = Vc_12_In_One()
        } else if indexPath.row == 11 {
//            vc = Vc_13_In_One()
        }
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
