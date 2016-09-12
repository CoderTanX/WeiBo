//
//  TAXComposeTextView.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/9/8.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXComposeTextView: UITextView {

    lazy var placeHolderLabel : UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPlaceHolderLabel()
    }
}
//MARK: - 设置UI
extension TAXComposeTextView {
    ///设置站位文字
    private func setupPlaceHolderLabel(){
        addSubview(placeHolderLabel)
        placeHolderLabel.snp_makeConstraints { (make) in
            make.top.equalTo(7)
            make.left.equalTo(10)
        }
        placeHolderLabel.text = "分享新鲜事..."
        placeHolderLabel.font = font
        placeHolderLabel.textColor = UIColor.lightGrayColor()
        
        textContainerInset = UIEdgeInsets(top: 7, left: 7, bottom: 0, right: 7)
    }
    
}
