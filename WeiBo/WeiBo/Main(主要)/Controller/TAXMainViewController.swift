//
//  TAXMainViewController.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/19.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXMainViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        addChildViewController(TAXHomeViewController(), title: "首页", image: "tabbar_home")
        addChildViewController(TAXMessageViewController(), title: "消息", image: "tabbar_message_center")
        addChildViewController(TAXDiscoverViewController(), title: "发现", image: "tabbar_discover")
        addChildViewController(TAXProfileViewController(), title: "我", image: "tabbar_profile")

    }
    
    func addChildViewController(childController: UIViewController, title: String, image: String) {
        
        childController.title = title
        childController.tabBarItem.image = UIImage(named: image)
        childController.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")
        addChildViewController(UINavigationController(rootViewController: childController))
        
    }
    
    

}