//
//  UIBarButtonItem-Extension.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/24.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String) {
        self.init()
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        self.customView = btn
    }
}