//
//  TAXPresentationController.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/25.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXPresentationController: UIPresentationController {
    
    lazy var converView : UIView = UIView()
    var presentedViewFrame : CGRect = CGRectZero
    
    //MARK: - 系统回调函数
    override func containerViewWillLayoutSubviews() {
        
        super.containerViewWillLayoutSubviews()
        
        presentedView()?.frame = presentedViewFrame
        
        setupConverView()
        
    }
}
//MARK: - 初始化UI
extension TAXPresentationController{
    
    private func setupConverView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeContainerView))
        converView.frame = containerView!.bounds
        converView .addGestureRecognizer(tap)
        converView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        containerView?.insertSubview(converView, atIndex: 0)
    }
    
}

//MARK: - 监听点击事件
extension TAXPresentationController {
    @objc private func removeContainerView(){
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
