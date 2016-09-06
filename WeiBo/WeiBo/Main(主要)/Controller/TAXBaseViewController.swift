//
//  TAXBaseViewController.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/23.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXBaseViewController: UITableViewController {
    
    var isLogin : Bool = TAXUserAccountViewModel.shareInstance.isLogin

    lazy var vistorView = TAXVistorView.vistorView()
    
    override func loadView() {
    
        isLogin ? super.loadView() : setupVistorView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(TAXUserAccountViewModel.shareInstance.userAccount?.access_token);
        if !isLogin {
            setupNavigationItems()
        }
        
    }

}
//MARK: - 初始化界面
extension TAXBaseViewController {
    
    ///创建登录界面
    private func setupVistorView(){
        view = vistorView
        vistorView.registerBt.addTarget(self, action: #selector(registerBtClick), forControlEvents: .TouchUpInside)
        vistorView.loginBtClick.addTarget(self, action: #selector(loginBtClick), forControlEvents: .TouchUpInside)
    }
    ///设置NavigationItems
    private func setupNavigationItems(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: #selector(loginBtClick))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: #selector(registerBtClick))
    }
}

//MARK: - 监听点击事件
extension TAXBaseViewController {
    @objc private func registerBtClick(){
        print("注册点击了")
    }
    @objc private func loginBtClick(){
//        print("登录点击了")
        let oAuthNav = UINavigationController.init(rootViewController: TAXOAuthViewController())
        self.presentViewController(oAuthNav, animated: true, completion: nil)
        
    }
}