//
//  Vc_TV_In_One.swift
//  RXPractice
//
//  Created by yuency on 26/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxSwift


//这里我们使用 RXSwift 进行改造, (响应式编程)

class Vc_TV_In_One: UITableViewController {
    
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //这里我们不再需要实现数据源和委托协议了。而是写一些响应式代码，让它们将数据和 UITableView 建立绑定关系。
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
        /*
         DisposeBag：作用是 Rx 在视图控制器或者其持有者将要销毁的时候，自动释法掉绑定在它上面的资源。它是通过类似“订阅处置机制”方式实现（类似于 NotificationCenter 的 removeObserver）。
         rx.items(cellIdentifier:）:这是 Rx 基于 cellForRowAt 数据源方法的一个封装。传统方式中我们还要有个 numberOfRowsInSection 方法，使用 Rx 后就不再需要了（Rx 已经帮我们完成了相关工作）。
         rx.modelSelected： 这是 Rx 基于 UITableView 委托回调方法 didSelectRowAt 的一个封装。
         */
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
        
        //FIXME: -  这个方法不知道从哪里打出来
        musicListViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier:"musicCell")) { _, music, cell in
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
            }.disposed(by: disposeBag)
        
        
        //tableView点击响应
        tableView.rx.modelSelected(Music.self).bind { (music) in
            print("你选中的歌曲信息【\(music)】")
            }.disposed(by: disposeBag)
       
        /*
         tableView.rx.modelDeselected(Music.self).bind { (music) in  // 这个方法是反选..
         print("你选中的歌曲信息【\(music)】")
         }.disposed(by: disposeBag)
         */
        
    }
    
    /// 把协议的部分都去掉了...
    
}




//歌曲结构体
struct Music {
    let name: String //歌名
    let singer: String //演唱者
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Music: CustomStringConvertible {
    var description: String {
        return "name：\(name) singer：\(singer)"
    }
}


//歌曲列表数据源
// 使用响应式编程第一步要对 ViewModel 进行修改,  将 Data 属性变成一个可观察的对象, 只是变成了一个可以观察的对象而已 , 内容并没有发生变化
// 简单说就是 "序列" 可以对这些数值进行 "订阅" 有点类似于 "通知"
struct MusicListViewModel {
    
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "后会无期", singer: "朴树"),
        ])
    
    //    let data = [
    //        Music(name: "无条件", singer: "陈奕迅"),
    //        Music(name: "你曾是少年", singer: "S.H.E"),
    //        Music(name: "从前的我", singer: "陈洁仪"),
    //        Music(name: "后会无期", singer: "朴树"),
    //        ]
}



