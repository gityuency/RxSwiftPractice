//
//  ValidationService.swift
//  RXPractice
//
//  Created by yuency on 13/02/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift



class RegisterViewModel {
    //input:
    let username = Variable<String>("") //初始值为""
    
    // output:
    let usernameUsable: Observable<Result>
    
    init() {
        
        
        let service = ValidationService.instance
        
        usernameUsable = username.asObservable()
            .flatMapLatest{ username in
                return service.validateUsername(username)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.failed(message: "username检测出错"))
            }
            .share(replay: 1)
    }
}



class ValidationService {
    
    static let instance = ValidationService()
    
    private init() {}
    
    let minCharactersCount = 6
    
    //这里面我们返回一个Observable对象，因为我们这个请求过程需要被监听。
    func validateUsername(_ username: String) -> Observable<Result> {
        
        if username.count == 0 {//当字符等于0的时候什么都不做
            return .just(.empty)
        }
        
        if username.count < minCharactersCount {//当字符小于6的时候返回failed
            return .just(.failed(message: "号码长度至少6个字符"))
        }
        
        if usernameValid(username) {//检测本地数据库中是否已经存在这个名字
            return .just(.failed(message: "账户已存在"))
        }
        
        return .just(.ok(message: "用户名可用"))
    }
    
    // 从本地数据库中检测用户名是否已经存在
    func usernameValid(_ username: String) -> Bool {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        let usernameArray = userDic!.allKeys as NSArray
        if usernameArray.contains(username) {
            return true
        } else {
            return false
        }
    }
}

