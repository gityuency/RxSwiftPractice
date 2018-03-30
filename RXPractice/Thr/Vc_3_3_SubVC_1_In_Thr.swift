//
//  Vc_3_3_SubVC_1_In_Thr.swift
//  RXPractice
//
//  Created by yuency on 30/03/2018.
//  Copyright © 2018 钉宫理惠. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


enum XingBieEnum {
    case meiyou
    case nan
    case nv
}



class Vc_3_3_SubVC_1_In_Thr: UIViewController {
    
    @IBOutlet var shengri: UILabel!
    
    @IBOutlet var shijianxuanzeqi: UIDatePicker!
    
    @IBOutlet var nan: UIButton!
    
    @IBOutlet var nv: UIButton!
    
    @IBOutlet var kaiguan: UISwitch!
    
    @IBOutlet var huadongitao: UISlider!
    
    @IBOutlet var jiajian: UIStepper!
    
    @IBOutlet var tubiaogaodu: NSLayoutConstraint!
    
    @IBOutlet var anniu: UIButton!
    
    let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        shijianxuanzeqi.layer.borderWidth = 1
        
        //        let b = UIDatePicker()
        
        // 这里处理生日
        let shengriOB = shijianxuanzeqi.rx.date.map { date -> Bool in
            return InputValidator.isValidDate(date: date)
        }
        shengriOB
            .map { ok -> UIColor in
                ok ? UIColor.green : UIColor.red
            }
            .subscribe(onNext: { color in
                self.shijianxuanzeqi.layer.borderColor = color.cgColor
            })
            .disposed(by: disposeBag)
        
        
        //这里处理性别按钮
        let xingbiexuanzeV = Variable<XingBieEnum>(.meiyou)
        
        self.nan.rx.tap
            .map { _ -> XingBieEnum in
                return .nan
            }
            .bind(to: xingbiexuanzeV) //这也是一种订阅, 这种订阅把值传给了 xingbiexuanzeV ????
            .disposed(by: disposeBag)
        
        self.nv.rx.tap
            .map { _ -> XingBieEnum in
                return .nv
            }
            .bind(to: xingbiexuanzeV)  //当按钮点击的时候, 这个 xingbiexuanzeV 就会收到不同的值
            .disposed(by: disposeBag)
        
        xingbiexuanzeV.asObservable().subscribe(onNext: { xingbie in
            switch xingbie {
            case .nan:
                self.nan.setImage(UIImage(named: "broadcast_family_selected"), for: .normal)
                self.nv.setImage(UIImage(named: "broadcast_family_normal"), for: .normal)
            case .nv:
                self.nan.setImage(UIImage(named: "broadcast_family_normal"), for: .normal)
                self.nv.setImage(UIImage(named: "broadcast_family_selected"), for: .normal)
            default:
                break
            }
            
        }).disposed(by: disposeBag)
        
        //把这个 性别 的 subject 做成 OB 使用了 Map 等操作符 返回的东西也是 OB, 只不过 这个 泛型类 OB 携带的数据类型不一样了, 但是仍然是 OB
        let xingbieOB = xingbiexuanzeV.asObservable().map { xignbie -> Bool in
            return xignbie != .meiyou ? true : false  // 这里制作了一个性别 的 OB 对于性别的 OB 可以加工想要的东西,
        }
        
        /// 这个东西 如果 接受了 OB (四种 Subject ) 对象, 那么, 在 Subject 对象发送 消息的时候, 这段代码就会自动触发事件
        Observable
            .combineLatest(shengriOB, xingbieOB) { (shengriOK, xignbieOK) -> [Bool] in  //从 OB 得到的结果是 bool 值
                return [shengriOK, xignbieOK]
            }
            .map { boolArray -> Bool in
                boolArray.reduce(true, { $0 && $1 })
            }
            .bind(to: anniu.rx.isEnabled)   //这个东西是 管理按钮是否点击的
            .disposed(by: disposeBag)
        
        
        
        //这次我们处理 开关 和 滑动条 的联动功能  这其实是一个双向绑定的过程
        self.kaiguan.rx.value
            .map {
                $0 ? 0.25 : 0  // 把开关的状态转换成为 浮点数
            }
            .bind(to: self.huadongitao.rx.value) // 这里就是订阅开关的状态, 并且把收到的值 ,赋值 给 滑动条
            .disposed(by: disposeBag)
        
        self.huadongitao.rx.value
            .map { shuzhi -> Bool in
                return shuzhi == 0 ? false : true
            }
            .bind(to: self.kaiguan.rx.value)
            .disposed(by: disposeBag)
        
        
        ///处理加号和图片之间的关系
        self.jiajian.rx.value
        .skip(1)   //由于程序一开始加载的时候会执行这段代码, 也就会 走到 subscribe 函数, 就会执行里面的代码, 但是这不是希望看到的, 这里就跳过第一次的订阅,
        .subscribe(onNext: { zhi in
            self.tubiaogaodu.constant = CGFloat(zhi - 1)
        }).disposed(by: disposeBag)
        
        
        
    }
}
