//
//  TAXVistorView.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/23.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXVistorView: UIView {
   
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var registerBt: UIButton!
    @IBOutlet weak var loginBtClick: UIButton!
    
    class func vistorView() -> TAXVistorView {
        return NSBundle.mainBundle().loadNibNamed("TAXVistorView", owner: nil, options: nil).first as! TAXVistorView
    }
    
    func setupVistorViewInfo(iconName: String, title: String){
        iconView.image = UIImage(named: iconName)
        titleLabel.text = title
        rotationView.hidden = true
    }
    
    ///添加旋转动画
    func addRotationAnim(){
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.fromValue = 0
        anim.toValue = M_PI * 2
        anim.repeatCount = MAXFLOAT
        anim.duration = 8
        anim.removedOnCompletion = false
        rotationView.layer .addAnimation(anim, forKey: nil)
    }
}
