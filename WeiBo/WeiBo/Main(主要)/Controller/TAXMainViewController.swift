//
//  TAXMainViewController.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/19.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXMainViewController: UITabBarController {
    ///发布按钮
//    private lazy var composeBt = UIButton.createBtn("tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    private lazy var composeBt = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    ///MARK: - 系统的回调函数
    override func viewDidLoad() {
        
        super.viewDidLoad()
            setupComposeBt()
            
        }
}
//MARK: - 创建发布按钮
extension TAXMainViewController {
    ///创建发布按钮
    private func setupComposeBt(){
        composeBt.center = CGPointMake(tabBar.center.x, tabBar.bounds.height * 0.5)
        //添加到tabBar上
        tabBar.addSubview(composeBt)
        //添加composeBt点击事件
        composeBt.addTarget(self, action: #selector(composeBtClick), forControlEvents: .TouchUpInside)
    }
}
//MARK: - 事件监听
extension TAXMainViewController {
    @objc private func composeBtClick(){
        print("composeBtClick")
    }
}