//
//  Vc_3_5_In_Thr.swift
//  RXPractice
//
//  Created by yuency on 26/04/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class Vc_3_5_In_Thr: UIViewController {
    
    @IBOutlet var shurukuang: UITextField!
    
    @IBOutlet var biaoge: UITableView!
    
    @IBOutlet var button: UIButton!
    
    let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Demo_1()
        
    }
    
    
    
    //MARK: - 示例代码 1
    func Demo_1() {
        biaoge.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //随机的表格数据
        let buttonRandomResult = button.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest(getRandomResult)
            .share(replay: 1)
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource <YuencySection>(configureCell: { (dataSource, tv, indexPath, element) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "条目\(indexPath.row)：\(element.content ?? "没有结果")"
            return cell
        })
        //绑定单元格数据
        buttonRandomResult.bind(to: biaoge.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    //点击按钮! 获取随机数据
    func getRandomResult() -> Observable<[YuencySection]> {
        print("正在请求数据......")
        let k = Int(arc4random() % 10)
        var array = [YuencyItem]()
        for i in 0..<k {
            array.append(YuencyItem(number: i, content: String(arc4random())))
        }
        let mmm = YuencySection(header: "", numbers: array)
        let observable = Observable.just([mmm])
        return observable.delay(0.5, scheduler: MainScheduler.instance)
    }
    
}




//MARK: - 模型
struct YuencySection {
    var header: String
    var numbers: [YuencyItem]
    init(header: String, numbers: [Item]) {
        self.header = header
        self.numbers = numbers
    }
}

extension YuencySection: AnimatableSectionModelType {
    typealias Item = YuencyItem
    typealias Identity = String
    var identity: String {
        return header
    }
    var items: [YuencyItem] {
        return numbers
    }
    init(original: YuencySection, items: [Item]) {
        self = original
        self.numbers = items
    }
}


struct YuencyItem {
    let number: Int
    
    //自定义属性
    var content: String?
    
}

extension YuencyItem : IdentifiableType, Equatable {
    typealias Identity = Int
    var identity: Int {
        return number
    }
    static func == (lhs: YuencyItem, rhs: YuencyItem) -> Bool {
        return lhs.number == rhs.number
    }
}

