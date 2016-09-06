//
//  UIButton-Extension.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/23.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

extension UIButton {
    /*
    class func createBtn(imageName: String, bgImageName: String ) -> UIButton {
        
        //创建按钮
        let btn = UIButton(type: .Custom)
        //设置属性
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        return btn
        
    }*/
    
    convenience init(imageName: String, bgImageName: String){
        self.init()
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), forState: .Highlighted)
        sizeToFit()
        
    }
    
}