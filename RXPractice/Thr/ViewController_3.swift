//
//  ViewController_3.swift
//  RXPractice
//
//  Created by yuency on 30/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController_3: UIViewController {
    
    @IBOutlet var tableview: UITableView!
    
    
    let myArray = [
        "理解了Reactive Programming的编程思想之后，在这段视频里，我们使用RxSwift来实现上个视频中“筛选用户输入偶数”的例子，以此来进一步了解Reactive Programming中的各种思想的具体实现。",
        "理解Disposable & DisposeBag",
        "RxSwift UI交互 - I \nRxSwift UI交互 - II \nRxSwift UI交互 - III",
        "基于RxSwift的网络编程 - I",
        "RxSwift 表格示例代码",
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


extension ViewController_3: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ViewController_3_CELL_ID")
        cell.textLabel?.text = myArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "今天被剥削了......."
        cell.imageView?.image = UIImage(named: "a10.jpg")
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vc = UIViewController()
        
        if indexPath.row == 0 {
            vc = Vc_3_1_In_Thr()
        } else if indexPath.row == 1 {
            vc = Vc_3_2_In_Thr()
        } else if indexPath.row == 2 {
            vc = Vc_3_3_In_Thr()
        } else if indexPath.row == 3 {
            vc = Vc_3_4_In_Thr()
        } else if indexPath.row == 4 {
            vc = Vc_3_5_In_Thr()
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

