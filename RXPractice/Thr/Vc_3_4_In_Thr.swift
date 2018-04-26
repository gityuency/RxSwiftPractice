//
//  Vc_3_4_In_Thr.swift
//  RXPractice
//
//  Created by yuency on 04/04/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire

class Vc_3_4_In_Thr: UIViewController {
    
    @IBOutlet var resTF: UITextField!
    
    @IBOutlet var tableview: UITableView!
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Observable<Bool>.create { ob -> Disposable in
            
            ob.onNext(true)
            
            
            return Disposables.create()
        }
        
        
        resTF.rx.text
            .filter({ string -> Bool in    //在程序启动的时候会订阅一次, 输入框成为第一响应的时候也会订阅一次, 在输入字符较少的时候还会订阅,这些都是无效的字符, 在这里进行过滤
                if let s = string , s.count > 2 {
                    return true
                } else {
                    return false
                }
            })
            .flatMap({ input -> Observable<EFUser> in //这个地方用的 ?? !
                return self.searchForGithub(repositoryName: input!)
            })
            .throttle(0.5, scheduler: MainScheduler.instance)  // 输入时间间隔太短的时候会频繁发起请求, 在这里设定请求时间间隔为 0.5 秒, 在主线程
            .subscribe(onNext: { user in
                
                print("得到的内容是 \(user.total_count) \(user.items) \n")
                
            }).disposed(by: bag)
        
    }
}



extension Vc_3_4_In_Thr {
    
    private func searchForGithub(repositoryName: String) -> Observable<EFUser> {
        
        return Observable.create {(observer: AnyObserver<EFUser>) -> Disposable in
            
            let url = "https://api.github.com/search/repositories"
            let parameters = [
                "q": repositoryName + " stars:>=2000"
            ]
            
            let r = Alamofire.request(url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
                .responseString(completionHandler: { response in
                    if let json = response.result.value  {
                        let decoder = JSONDecoder()
                        guard let jsonData = json.data(using: String.Encoding.utf8),
                            let userModel = try? decoder.decode(EFUser.self, from: jsonData)
                            else {
                                return
                        }
                        observer.onNext(userModel)
                        observer.onCompleted()
                        
                    } else {
                        let error: Error = "fdsa" as! Error
                        observer.onError(error)
                    }
                })
            return Disposables.create()
        }
    }
}




class EFUser:Codable {
    var total_count: Int = 0
    var items = [ItemModel]()
}


class ItemModel: Codable {
    var id: Int = 0
    var name: String?
    var full_name: String?
    var owner: Owner?
}


class Owner: Codable {
    var avatar_url: String?
    var repos_url: String?
}








