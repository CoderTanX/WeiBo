//
//  TAXTitleBtn.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/24.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXTitleBtn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width + 6
    }
}
