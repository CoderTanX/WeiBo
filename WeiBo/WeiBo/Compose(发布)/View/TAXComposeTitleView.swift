//
//  TAXComposeTitleView.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/9/8.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import SnapKit

class TAXComposeTitleView: UIView {

    private lazy var titleLabel : UILabel = UILabel()
    private lazy var screenNameLabel : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK: - 设置UI
extension TAXComposeTitleView {
    private func setupUI(){
        
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        
        screenNameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp_bottom)
        }
        // 3.设置空间的属性
        titleLabel.font = UIFont.systemFontOfSize(16)
        screenNameLabel.font = UIFont.systemFontOfSize(14)
        screenNameLabel.textColor = UIColor.lightGrayColor()
        
        // 4.设置文字内容
        titleLabel.text = "发微博"
        screenNameLabel.text = TAXUserAccountViewModel.shareInstance.userAccount?.screen_name

    }
}
