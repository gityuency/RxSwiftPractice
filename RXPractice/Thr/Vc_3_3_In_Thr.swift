//
//  Vc_3_3_In_Thr.swift
//  RXPractice
//
//  Created by yuency on 30/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Vc_3_3_In_Thr: UIViewController {
    
    
    @IBOutlet var emailTF: UITextField!
    
    @IBOutlet var pwdTF: UITextField!
    
    @IBOutlet var button: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.emailTF.layer.borderWidth = 1
        self.pwdTF.layer.borderWidth = 1
        
        
        let eOB = emailTF.rx.text
            .map { input -> Bool in //这一步先验证邮箱合法
                
                return InputValidator.isValidEmail(email: input!)
        }
        
        eOB.map { valid -> UIColor in  //这一步 当邮箱合法的时候处理 把合法这个事件变换成为 颜色值, 从一个 对象变换成另外一个对象
            
            return valid ? UIColor.green : UIColor.red
            
            }.subscribe(onNext: { color in  // 在这里订阅到我们最终需要的值, 然后把这个值 显示到 UI 上
                
                self.emailTF.layer.borderColor = color.cgColor
                
            }).disposed(by: disposeBag)   //通过步骤来分析需要的那些东西, 然后把原始数据 逐步处理 最终变成我们想要的数据
        
        
        
        let pOB = pwdTF.rx.text
            .map { input -> Bool in
                return InputValidator.isValidPassword(password: input!)
        }
        pOB.map { valid -> UIColor in
            return valid ? UIColor.green : UIColor.red
            }.subscribe(onNext: { color in
                self.pwdTF.layer.backgroundColor = color.cgColor
            }).disposed(by: disposeBag)
        
        
        //当上面的两个 事件的序列值的 最新的事件 都是合法的, 就让按钮干活   这个 OB 的返回结果是 bool 值, 所以在这里的 闭包参数也就是布尔值
        
        Observable
            .combineLatest(eOB, pOB) { (emailOK, pwdOK) -> [Bool] in // 闭包的返回值你可以随便写, 你要返回什么就写什么
                return [emailOK, pwdOK]
            }
            .map { boolArray -> Bool in
                return boolArray.reduce(true, { $0 && $1 }) //iOS 自带的 数组的计算方法, 对数组的每一个元素都做事情
                
            }.subscribe(onNext: { ok in
                
//                self.button.isEnabled = ok
                
            }).disposed(by: disposeBag)

        
    }
    
    
    
    
    @IBAction func buttonAction(_ sender: Any) {
        
        let vc = Vc_3_3_SubVC_1_In_Thr()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}


// MARK: - 验证邮箱

class InputValidator {
    
    class func isValidEmail(email: String) -> Bool {
        let re = try? NSRegularExpression(
            pattern: "^\\S+@\\S+\\.\\S+$",
            options: .caseInsensitive)
        
        if let re = re {
            let range = NSMakeRange(0, email.lengthOfBytes(using: String.Encoding.utf8))
            
            let result = re.matches(in: email, options: .reportProgress, range: range)
            
            return result.count > 0
        }
        
        return false
    }
    
    
    class func isValidPassword(
        password: String) -> Bool {
        return password.count >= 8
    }
    
    
    class func isValidDate(date: Date) -> Bool {
        let calendar = NSCalendar.current
        let compare = calendar.compare(date, to: Date(), toGranularity: .day)
        return compare == .orderedAscending
    }
}
